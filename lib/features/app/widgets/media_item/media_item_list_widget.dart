import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifiers/audio/audio_queue_notifier.dart';
import 'media_item_widget.dart';

class MediaItemListWidget extends ConsumerWidget {
  final List<MediaItem> mediaItems;
  const MediaItemListWidget({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(audioQueueProvider.notifier);
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mediaItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final mediaItem = mediaItems[index];
        return MediaItemWidget(
          mediaItem: mediaItem,
          onTap:
              () => notifier.playMediaItems(
                mediaItems: mediaItems,
                initialIndex: index,
              ),
          options: [
            PopupMenuItem(
              child: Text("Add to queue"),
              onTap: () => notifier.addToQueue(mediaItem),
            ),
            PopupMenuItem(
              child: Text("Remove from queue"),
              onTap: () => notifier.removeFromQueue(mediaItem),
            ),
          ],
        );
      },
    );
  }
}
