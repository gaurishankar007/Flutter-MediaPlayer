import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifiers/audio/audio_queue_notifier.dart';
import '../media_player/media_play_button_widget.dart';

class TrackPlayButtonWidget extends ConsumerWidget {
  /// Identify whether this media (whose id is the identifier) is being played or not
  final String? identifier;
  final List<MediaItem> mediaItems;
  final double? iconSize;
  final Color? iconColor;

  const TrackPlayButtonWidget({
    super.key,
    this.identifier,
    this.iconSize,
    this.iconColor,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(audioQueueProvider.notifier);
    final mediaItem = ref.watch(
      audioQueueProvider.select((state) => state.mediaItem),
    );

    // If the identifier is from the current media item or playlist
    if (mediaItem?.album == identifier || mediaItem?.id == identifier) {
      return MediaPlayButtonWidget(iconSize: iconSize, iconColor: iconColor);
    }

    return IconButton(
      onPressed:
          () async => await notifier.playMediaItems(mediaItems: mediaItems),
      icon: Icon(
        Icons.play_arrow_rounded,
        size: iconSize,
        color: iconColor ?? Colors.deepPurple,
      ),
    );
  }
}
