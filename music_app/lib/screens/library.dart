import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widgets/navigator.dart';
import 'package:music_app/widgets/song_bar.dart';

import '../player.dart';

class Library extends StatefulWidget {
  final int? pageIndex;
  const Library({Key? key, @required this.pageIndex}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final AudioPlayer player = Player.player;

  late StreamSubscription stateSub;

  bool songBarVisibility = false;

  @override
  void initState() {
    super.initState();

    stateSub = player.onPlayerStateChanged.listen((state) {
      setState(() {
        songBarVisibility = Player.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    stateSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Your Library"),
        ),
      ),
      floatingActionButton: songBarVisibility
          ? SongBar(
              songData: Player.playingSong,
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      bottomNavigationBar: PageNavigator(
        pageIndex: widget.pageIndex,
      ),
    );
  }
}
