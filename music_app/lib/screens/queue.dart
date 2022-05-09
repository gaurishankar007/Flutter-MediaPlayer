import 'package:flutter/material.dart';
import 'package:music_app/widgets/song_bar.dart';

import '../player.dart';

class SongQueue extends StatefulWidget {
  const SongQueue({
    Key? key,
  }) : super(key: key);

  @override
  State<SongQueue> createState() => _SongQueueState();
}

class _SongQueueState extends State<SongQueue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Text("Song Queue"),
        ),
      ),
      floatingActionButton: Player.playingSong != null
          ? SongBar(
              songData: Player.playingSong,
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
