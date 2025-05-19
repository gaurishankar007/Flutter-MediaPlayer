import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../music/views/media/media_view.dart';
import '../../notifiers/audio/audio_queue_notifier.dart';
import 'media_play_button_widget.dart';
import 'media_seeker_widget.dart';

class MediaPlayerWidget extends ConsumerWidget {
  const MediaPlayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaItem = ref.watch(
      audioQueueProvider.select((state) => state.mediaItem),
    );

    if (mediaItem == null) return SizedBox.shrink();

    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MediaView()),
          ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        mediaItem.artUri.toString(),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => SizedBox.shrink(),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mediaItem.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          mediaItem.artist ?? "",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    Spacer(),
                    MediaPlayButtonWidget(
                      iconColor: Colors.white,
                      iconSize: 32,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 8),
            MediaSeekerWidget(thumbRadius: 0),
          ],
        ),
      ),
    );
  }
}
