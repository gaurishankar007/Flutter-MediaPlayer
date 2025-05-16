part of 'audio_media_notifier.dart';

class AudioMediaState {
  final List<MediaItem> mediaItems;

  const AudioMediaState({required this.mediaItems});

  const AudioMediaState.empty() : this(mediaItems: const []);

  AudioMediaState copyWith({List<MediaItem>? mediaItems}) {
    return AudioMediaState(mediaItems: mediaItems ?? this.mediaItems);
  }
}
