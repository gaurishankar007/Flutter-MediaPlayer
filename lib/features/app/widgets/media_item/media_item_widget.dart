import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../play_button/playing_icon_widget.dart';

class MediaItemWidget extends StatelessWidget {
  final MediaItem mediaItem;
  final Function()? onTap;
  final List<PopupMenuItem> options;

  const MediaItemWidget({
    super.key,
    required this.mediaItem,
    this.onTap,
    this.options = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.all(4),
        minVerticalPadding: 1,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              Image.network(
                mediaItem.artUri.toString(),
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => SizedBox.shrink(),
              ),
              PlayingIconWidget(identifier: mediaItem.id),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mediaItem.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              mediaItem.artist ?? "",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
        trailing:
            options.isEmpty
                ? null
                : PopupMenuButton(itemBuilder: (context) => options),
      ),
    );
  }
}
