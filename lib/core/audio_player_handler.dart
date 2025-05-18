import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

@module
abstract class AppAudioHandlerModule {
  @lazySingleton
  AudioPlayer get player => AudioPlayer();
}

@LazySingleton()
class AudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  final AudioPlayer _audioPlayer;
  bool _isPlayerListenerActivated = false;

  // Audio Player stream subscriptions
  StreamSubscription<PlaybackEvent>? _playbackEventSubscription;
  StreamSubscription<int?>? _currentIndexSubscription;
  StreamSubscription<ProcessingState>? _processingStateSubscription;

  AudioPlayerHandler({
    required AudioPlayer audioPlayer,
    required AudioPlayer miniAudioPlayer,
  }) : _audioPlayer = audioPlayer;

  // <---------- region Basic Controls ---------->
  @override
  Future<void> play() => _audioPlayer.play();

  @override
  Future<void> pause() => _audioPlayer.pause();

  @override
  Future<void> stop() async {
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.stop();
  }

  @override
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  @override
  Future<void> setSpeed(double speed) => _audioPlayer.setSpeed(speed);

  @override
  Future<void> skipToPrevious() async {
    final isFirstAudioSource = _audioPlayer.currentIndex == 0;
    if (!isFirstAudioSource) await super.skipToPrevious();
  }

  @override
  Future<void> skipToNext() async {
    final isLastAudioSource =
        _audioPlayer.currentIndex == _audioPlayer.audioSources.length - 1;
    if (!isLastAudioSource) await super.skipToNext();
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    final mediaItemIndex = queue.value.indexOf(mediaItem);
    // If the media item does not exist in the queue
    if (mediaItemIndex == -1) return await setMediaItems([mediaItem]);
    // Skip to the next media item if it exists
    await skipToQueueItem(mediaItemIndex);
  }
  // <---------- endregion ---------->

  // <---------- region Playback Mode Controls ---------->
  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    LoopMode loopMode = LoopMode.all;
    if (repeatMode == AudioServiceRepeatMode.none) loopMode = LoopMode.off;
    if (repeatMode == AudioServiceRepeatMode.one) loopMode = LoopMode.one;
    await _audioPlayer.setLoopMode(loopMode);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    bool isShuffleModeEnabled = shuffleMode != AudioServiceShuffleMode.none;
    await _audioPlayer.setShuffleModeEnabled(isShuffleModeEnabled);
  }
  // <---------- endregion ---------->

  // <---------- region Queue Management ---------->
  @override
  Future<void> skipToQueueItem(int index) =>
      _audioPlayer.seek(Duration.zero, index: index);

  Future<void> setMediaItems(
    List<MediaItem> mediaItems, {
    int initialIndex = 0,
    bool autoPlay = true,
  }) async {
    // Discard operation on invalid arguments
    bool invalidIndex = initialIndex < 0 || initialIndex >= mediaItems.length;
    if (mediaItems.isEmpty || invalidIndex) return;

    // Clean up existing playback (stop players, cancel listeners)
    await _resetPlayerState();

    // Update audio_service's playlist (atomic update)
    queue.value = [...mediaItems];

    // Update just_audio's playlist
    try {
      await _audioPlayer.setAudioSources(
        mediaItems.map((e) => AudioSource.uri(Uri.parse(e.id))).toList(),
        initialIndex: initialIndex,
      );

      // Activate listeners after sources are set
      _activateListeners();

      // Start playback if requested
      if (autoPlay) await play();
    } catch (e) {
      debugPrint('Error setting media items: $e');
      rethrow;
    }
  }

  Future<void> addMediaItems(List<MediaItem> mediaItems) async {
    if (mediaItems.isEmpty) return;

    // Add to audio_service's queue
    await addQueueItems(mediaItems);

    // Add to just_audio's playlist
    await _audioPlayer.addAudioSources(
      mediaItems.map((e) => AudioSource.uri(Uri.parse(e.id))).toList(),
    );
  }

  Future<void> removeMediaItem(MediaItem mediaItem) async {
    final mediaIndex = queue.value.indexWhere((e) => e.id == mediaItem.id);
    if (mediaIndex == -1) return;

    // Remove from audio service's queue
    await removeQueueItem(mediaItem);

    // Remove from just_audio's playlist
    await _audioPlayer.removeAudioSourceAt(mediaIndex);
  }
  // <---------- endregion ---------->

  // <---------- region player Streams ---------->
  Stream<List<MediaItem>> get queueStream => queue.stream.asBroadcastStream();

  Stream<MediaItem?> get mediaItemStream =>
      mediaItem.stream.asBroadcastStream();

  Stream<Duration?> get positionStream =>
      _audioPlayer.positionStream.asBroadcastStream();

  Stream<LoopMode> get loopModeStream =>
      _audioPlayer.loopModeStream.asBroadcastStream();

  Stream<bool> get shuffleModeStream =>
      _audioPlayer.shuffleModeEnabledStream.asBroadcastStream();

  Stream<bool> get playingStream =>
      _audioPlayer.playingStream.asBroadcastStream();
  // <---------- endregion ---------->

  // <---------- region Listener Management
  void _activateListeners() {
    if (_isPlayerListenerActivated) return;
    _isPlayerListenerActivated = true;

    // Listen to just_audio's playback stream to update audio_service state.
    // This helps Android lock screen or iOS Control Center to update the playback state.
    _playbackEventSubscription = _audioPlayer.playbackEventStream.listen(
      _handlePlaybackEvent,
    );

    // Listen to just_audio's current audio source index to update audio_service current media item.
    _currentIndexSubscription = _audioPlayer.currentIndexStream.listen(
      _handleCurrentIndexChange,
    );

    // Listen to just_audio's state changes to skipToNext when completed
    _processingStateSubscription = _audioPlayer.processingStateStream.listen(
      _handleProcessingStateChange,
    );
  }

  void _handlePlaybackEvent(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: _buildMediaControls(),
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: _convertProcessingState(_audioPlayer.processingState),
        playing: _audioPlayer.playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  List<MediaControl> _buildMediaControls() => [
    MediaControl.skipToPrevious,
    if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
    MediaControl.skipToNext,
    MediaControl.stop,
  ];

  AudioProcessingState _convertProcessingState(ProcessingState state) {
    return switch (state) {
      ProcessingState.idle => AudioProcessingState.idle,
      ProcessingState.loading => AudioProcessingState.loading,
      ProcessingState.buffering => AudioProcessingState.buffering,
      ProcessingState.ready => AudioProcessingState.ready,
      ProcessingState.completed => AudioProcessingState.completed,
    };
  }

  void _handleCurrentIndexChange(int? index) {
    final currentMediaItems = queue.value;
    if (index == null || currentMediaItems.isEmpty) return;
    mediaItem.add(currentMediaItems[index]);
  }

  void _handleProcessingStateChange(ProcessingState state) {
    if (state == ProcessingState.completed) {
      final isLastAudioSource =
          _audioPlayer.currentIndex == _audioPlayer.audioSources.length - 1;

      if (isLastAudioSource) {
        stop();
      } else {
        skipToNext();
      }
    }
  }
  // <---------- endregion ---------->

  // <---------- region Cleanup Methods ---------->
  Future<void> _resetPlayerState() async {
    try {
      // Clear both players' resources
      await _audioPlayer.stop();
      await _audioPlayer.clearAudioSources();
      await _deactivateListeners();
      _isPlayerListenerActivated = false;

      // Clear audio service resources
      queue.add([]);
      mediaItem.add(null);
      queueTitle.add("");
      playbackState.add(
        PlaybackState(
          controls: [],
          systemActions: const {},
          processingState: AudioProcessingState.idle,
          playing: false,
          updatePosition: Duration.zero,
          bufferedPosition: Duration.zero,
          speed: 1.0,
          queueIndex: null,
        ),
      );
    } catch (e) {
      debugPrint('Error closing players: $e');
    }
  }

  Future<void> _deactivateListeners() async {
    // Cancel all subscriptions in parallel
    await Future.wait([
      _playbackEventSubscription?.cancel() ?? Future.value(),
      _currentIndexSubscription?.cancel() ?? Future.value(),
      _processingStateSubscription?.cancel() ?? Future.value(),
    ]);

    // Clear all subscription references
    _playbackEventSubscription = null;
    _currentIndexSubscription = null;
    _processingStateSubscription = null;
  }

  // <---------- endregion ---------->
}

/// A util class for accessing [AudioPlayerHandler]
class AudioHandlerUtil {
  AudioHandlerUtil._();

  /// Returns the registered instance of [AudioPlayerHandler] which is always the same
  static AudioPlayerHandler get I => GetIt.I<AudioPlayerHandler>();
}
