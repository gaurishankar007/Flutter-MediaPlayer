import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/api/http/album_http.dart';
import 'package:music_app/api/log_status.dart';
import 'package:music_app/screens/album.dart';
import 'package:music_app/widgets/navigator.dart';
import 'package:music_app/widgets/song_bar.dart';

import '../player.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  Future<List> viewAlbum() async {
    List resData = await AlbumHttp().getAlbums();
    return resData;
  }

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      LogStatus().removeToken();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/login",
                        (route) => false,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, -2),
                                )
                              ],
                            ),
                            child: Center(child: Text("hi")),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: sHeight * .01,
              ),
              FutureBuilder<List>(
                future: viewAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      padding: EdgeInsets.only(
                        top: sHeight * .01,
                        left: sWidth * .03,
                        right: sWidth * .03,
                        bottom: 20,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => AlbumView(
                                    albumId: snapshot.data![index]["_id"],
                                    pageIndex: 0,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: const [
                                    Color(0XFF36D1DC),
                                    Color(0XFF5B86E5),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(2, 2),
                                  )
                                ],
                              ),
                              child: Text(
                                snapshot.data![index]["title"],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "${snapshot.error}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.greenAccent,
                    ),
                  );
                },
              ),
            ],
          ),
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
        pageIndex: 0,
      ),
    );
  }
}
