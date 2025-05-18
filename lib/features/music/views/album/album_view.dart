import 'package:flutter/material.dart';

import '../../../app/data/models/music_album.dart';
import '../../../app/widgets/media_item/media_item_list_widget.dart';
import '../../../app/widgets/play_button/track_play_button_widget.dart';

class AlbumView extends StatelessWidget {
  final MusicAlbum album;
  const AlbumView({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(album.title)),
      body: ListView(
        children: [
          Image.network(
            album.photoUrl,
            width: double.maxFinite,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => SizedBox.shrink(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      album.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TrackPlayButtonWidget(
                      identifier: album.id,
                      mediaItems: album.songs,
                      iconSize: 40,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                MediaItemListWidget(mediaItems: album.songs),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
