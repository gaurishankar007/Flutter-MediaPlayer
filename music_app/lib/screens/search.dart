import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widgets/navigator.dart';
import 'package:music_app/widgets/song_bar.dart';

import '../player.dart';

class Search extends StatefulWidget {
  final int? pageIndex;
  const Search({Key? key, @required this.pageIndex}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
          child: Text("Search Song"),
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
