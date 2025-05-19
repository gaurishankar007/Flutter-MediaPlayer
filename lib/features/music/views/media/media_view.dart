import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/notifiers/audio/audio_queue_notifier.dart';
import '../../../app/widgets/media_player/media_controller_widget.dart';
import '../../../app/widgets/media_player/media_progress_widget.dart';
import '../../../app/widgets/media_player/media_seeker_widget.dart';

class MediaView extends ConsumerWidget {
  const MediaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaItem = ref.watch(
      audioQueueProvider.select((state) => state.mediaItem),
    );

    return Scaffold(
      appBar: AppBar(title: Text(mediaItem?.title ?? ""), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        mediaItem?.artUri.toString() ?? "",
                        width: double.maxFinite,
                        fit: BoxFit.fitWidth,
                        errorBuilder:
                            (context, error, stackTrace) => SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              mediaItem?.title ?? "",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(mediaItem?.artist ?? ""),
            SizedBox(height: 20),
            MediaSeekerWidget(
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.deepPurple.shade200,
              thumbColor: Colors.deepPurple,
            ),
            MediaProgressWidget(),
            SizedBox(height: 16),
            MediaControllerWidget(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
