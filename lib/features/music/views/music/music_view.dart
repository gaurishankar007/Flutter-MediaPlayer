import 'package:flutter/material.dart';

import 'widgets/music_album_list_widget.dart';

class MusicView extends StatelessWidget {
  const MusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: Text('Music'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Albums",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          MusicAlbumListWidget(),
          SizedBox(height: 16),
          Text(
            "Preview Songs",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
