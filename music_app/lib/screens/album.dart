import 'package:flutter/material.dart';
import 'package:music_app/api/http/song_http.dart';
import 'package:music_app/api/res/song_res.dart';
import 'package:music_app/widgets/navigator.dart';
import 'package:music_app/widgets/song_bar.dart';

import '../player.dart';

class AlbumView extends StatefulWidget {
  final String? albumId;
  final int? pageIndex;
  const AlbumView({Key? key, @required this.albumId, @required this.pageIndex})
      : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  GetSong? song = Player.playingSong;

  late List<GetSong> songs;

  Future<List<GetSong>> viewSongs() async {
    List<GetSong> resData = await SongHttp().getSongs(widget.albumId!);
    return resData;
  }

  @override
  void initState() {
    super.initState();

    viewSongs().then((value) {
      setState(() {
        songs = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<GetSong>>(
        future: viewSongs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    GetSong newSong = GetSong(
                      id: snapshot.data![index].id!,
                      title: snapshot.data![index].title!,
                      album: snapshot.data![index].album!,
                      music: snapshot.data![index].music!,
                      players: snapshot.data![index].players!,
                      likes: snapshot.data![index].likes!,
                    );

                    Player().playSong(newSong, songs);

                    setState(() {
                      song = newSong;
                    });
                  },
                  leading: Text("${index + 1}"),
                  title: Text(
                    snapshot.data![index].title!,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    snapshot.data![index].album!.title!,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Player.songQueue.add(GetSong(
                        id: snapshot.data![index].id!,
                        title: snapshot.data![index].title!,
                        album: snapshot.data![index].album!,
                        music: snapshot.data![index].music!,
                        players: snapshot.data![index].players!,
                        likes: snapshot.data![index].likes!,
                      ));
                    },
                    icon: Icon(
                      Icons.queue_play_next_rounded,
                      color: Colors.green,
                    ),
                  ),
                );
              },
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
      floatingActionButton: song != null
          ? SongBar(
              songData: song,
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      bottomNavigationBar: PageNavigator(pageIndex: widget.pageIndex),
    );
  }
}
