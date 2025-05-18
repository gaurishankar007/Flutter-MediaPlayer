import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/notifiers/audio/audio_queue_notifier.dart';
import '../../../app/widgets/media_item/media_item_list_widget.dart';
import '../../../app/widgets/media_item/media_item_widget.dart';

class QueueView extends ConsumerWidget {
  const QueueView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audioQueueProvider);

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: const Text('Queue'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          if (state.mediaItem != null) ...[
            Text(
              "Now Playing",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            MediaItemWidget(onTap: null, mediaItem: state.mediaItem!),
          ],
          if (state.nextFromQueue.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              "Next from Queue",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            MediaItemListWidget(mediaItems: state.nextFromQueue),
          ],
        ],
      ),
    );
  }
}
