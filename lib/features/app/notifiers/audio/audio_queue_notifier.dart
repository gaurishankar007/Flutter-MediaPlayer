import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/audio_player_handler.dart';

part 'audio_queue_state.dart';

final audioQueueProvider = StateNotifierProvider(
  (_) => AudioQueueNotifier(audioHandler: GetIt.I<AudioPlayerHandler>()),
);

class AudioQueueNotifier extends StateNotifier<AudioQueueState> {
  final AudioPlayerHandler _audioHandler;
  StreamSubscription<MediaItem?>? mediaItemSubscription;

  AudioQueueNotifier({required AudioPlayerHandler audioHandler})
    : _audioHandler = audioHandler,
      super(AudioQueueState.empty()) {
    _setUpQueueListener();
  }

  @override
  dispose() {
    mediaItemSubscription?.cancel();
    super.dispose();
  }

  /// Plays the medias of the album
  playMediaItems({
    required List<MediaItem> mediaItems,
    int initialIndex = 0,
  }) async {
    final mediaItem = mediaItems[initialIndex];
    // If media item is already playing, continue playing it
    if (mediaItem == state.mediaItem) return;

    final mediaItemIndex = _audioHandler.queue.value.indexOf(mediaItem);

    // If the media item does not exist in the queue, update the queue
    if (mediaItemIndex == -1) {
      await _audioHandler.setMediaItems(mediaItems, initialIndex: initialIndex);
    } else {
      await _audioHandler.skipToQueueItem(mediaItemIndex);
    }

    await _audioHandler.play();
  }

  addToQueue(MediaItem mediaItem) => _audioHandler.addMediaItems([mediaItem]);

  removeFromQueue(MediaItem mediaItem) {
    _audioHandler.removeMediaItem(mediaItem);
    List<MediaItem> mediaItems = [...state.nextFromQueue];
    mediaItems.removeWhere((e) => e.id == mediaItem.id);

    state = state.copyWith(nextFromQueue: mediaItems);
  }

  /// Updates current media item and next from queue (media item list)
  _setUpQueueListener() {
    mediaItemSubscription = _audioHandler.mediaItemStream.listen((mediaItem) {
      if (mediaItem == null) return;
      final currentMediaItems = [..._audioHandler.queue.value];
      final mediaItemIndex = currentMediaItems.indexOf(mediaItem);

      // If queue is empty, set state to empty
      if (currentMediaItems.isEmpty) {
        state = AudioQueueState.empty();
        return;
      }

      // If media item is in the queue, update next from queue list
      if (mediaItemIndex != -1) {
        List<MediaItem> mediaItems = [];
        // If media item is not the last item in the queue
        if (mediaItemIndex + 1 < currentMediaItems.length) {
          mediaItems = currentMediaItems.sublist(mediaItemIndex + 1);
        }

        state = state.copyWith(mediaItem: mediaItem, nextFromQueue: mediaItems);
      }
    });
  }
}
