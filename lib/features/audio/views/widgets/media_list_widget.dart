import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifiers/audio_media_notifier.dart';

class MediaListWidget extends ConsumerWidget {
  const MediaListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaItems = ref.watch(
      audioMediaProvider.select((state) => state.mediaItems),
    );

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mediaItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemBuilder: (context, index) {
        final mediaItem = mediaItems[index];
        return ListTile(
          leading: Image.network(
            mediaItem.artUri.toString(),
            height: 100,
            width: 100,
          ),
          title: Text(
            mediaItem.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.play_arrow_rounded),
          ),
        );
      },
    );
  }
}
