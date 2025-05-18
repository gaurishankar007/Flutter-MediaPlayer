part of 'audio_queue_notifier.dart';

class AudioQueueState extends Equatable {
  final MediaItem? mediaItem;
  final List<MediaItem> nextFromQueue;

  const AudioQueueState({required this.mediaItem, required this.nextFromQueue});

  const AudioQueueState.empty() : mediaItem = null, nextFromQueue = const [];

  AudioQueueState copyWith({
    MediaItem? mediaItem,
    List<MediaItem>? nextFromQueue,
  }) {
    return AudioQueueState(
      nextFromQueue: nextFromQueue ?? this.nextFromQueue,
      mediaItem: mediaItem ?? this.mediaItem,
    );
  }

  @override
  List<Object?> get props => [mediaItem, nextFromQueue];
}
