import 'dart:collection';
import "dart:math";
import 'package:audioplayers/audioplayers.dart';

import 'api/res/song_res.dart';
import 'api/urls.dart';

class Player {
  final songUrl = ApiUrls.songUrl;

  static final AudioPlayer player = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  static bool isPlaying = false;
  static bool isPaused = false;
  static bool isShuffle = false;
  static int isLoop = 0;
  static Duration duration = Duration.zero;
  static Duration position = Duration.zero;
  static GetSong? playingSong;

  static List<GetSong> songsList = [];

  static Queue<GetSong> prevSongs = Queue();
  static Queue<GetSong> currentSong = Queue();
  static Queue<GetSong> nextSongs = Queue();

  static Queue<GetSong> songQueue = Queue();

  void playSong(GetSong song, List<GetSong> songs) {
    if (playingSong == null) {
      songsList = songs;

      bool songFound = false;

      for (int i = 0; i < songsList.length; i++) {
        if (songFound == false) {
          if (song.id != songsList[i].id) {
            prevSongs.addFirst(songsList[i]);
          } else {
            currentSong.add(songsList[i]);
            songFound = true;
          }
        } else {
          nextSongs.add(songsList[i]);
        }
      }
    } else if (playingSong != null) {
      songsList = songs;
      prevSongs.clear();
      currentSong.clear();
      nextSongs.clear();

      bool songFound = false;

      for (int i = 0; i < songsList.length; i++) {
        if (songFound == false) {
          if (song.id != songsList[i].id) {
            prevSongs.addFirst(songsList[i]);
          } else {
            currentSong.add(songsList[i]);
            songFound = true;
          }
        } else {
          nextSongs.add(songsList[i]);
        }
      }
    }

    startPlaying(song);
  }

  void startPlaying(GetSong song) async {
    if (!isPlaying) {
      isPlaying = true;
      playingSong = song;
      await player.play(songUrl + song.music!);
    } else if (isPlaying && song.id! != playingSong!.id) {
      playingSong = song;
      await player.pause();
      await player.play(songUrl + song.music!);
    }
  }

  void autoNextSong() {
    if (songQueue.isEmpty) {
      if (nextSongs.isNotEmpty) {
        prevSongs.addFirst(currentSong.removeFirst());
        currentSong.add(nextSongs.removeFirst());
        startPlaying(currentSong.first);
      } else {
        if (isLoop == 2) {
          prevSongs.clear();
          currentSong.clear();

          for (int i = 0; i < songsList.length; i++) {
            if (i == 0) {
              currentSong.add(songsList[i]);
            } else {
              nextSongs.add(songsList[i]);
            }
          }
          startPlaying(currentSong.first);
        } else {
          return;
        }
      }
    } else {
      startPlaying(songQueue.removeFirst());
    }
  }

  void nextSong() {
    if (songQueue.isEmpty) {
      if (nextSongs.isNotEmpty) {
        prevSongs.addFirst(currentSong.removeFirst());
        currentSong.add(nextSongs.removeFirst());
        startPlaying(currentSong.first);
      } else {
        prevSongs.clear();
        currentSong.clear();

        for (int i = 0; i < songsList.length; i++) {
          if (i == 0) {
            currentSong.add(songsList[i]);
          } else {
            nextSongs.add(songsList[i]);
          }
        }

        startPlaying(currentSong.first);
      }
    } else {
      startPlaying(songQueue.removeFirst());
    }
  }

  void previousSong() {
    if (prevSongs.isNotEmpty) {
      nextSongs.addFirst(currentSong.removeFirst());
      currentSong.add(prevSongs.removeFirst());
      startPlaying(currentSong.first);
    } else {
      currentSong.clear();
      nextSongs.clear();

      for (int i = 0; i < songsList.length; i++) {
        if (i != songsList.length - 1) {
          prevSongs.addFirst(songsList[i]);
        } else {
          currentSong.add(songsList[i]);
        }
      }

      startPlaying(currentSong.first);
    }
  }

  void pauseSong() async {
    if (playingSong == null) {
      return;
    }
    isPaused = true;
    await player.pause();
  }

  void resumeSong() async {
    if (playingSong == null) {
      return;
    }
    isPaused = false;
    await player.resume();
  }

  void shuffleSong() {
    isShuffle = true;

    prevSongs.clear();
    currentSong.clear();
    nextSongs.clear();

  
  }

  void stopShuffle() {
    isShuffle = false;

    prevSongs.clear();
    currentSong.clear();
    nextSongs.clear();

    bool songFound = false;

    for (int i = 0; i < songsList.length; i++) {
      if (songFound == false) {
        if (playingSong!.id != songsList[i].id) {
          prevSongs.addFirst(songsList[i]);
        } else {
          currentSong.add(songsList[i]);
          songFound = true;
        }
      } else {
        nextSongs.add(songsList[i]);
      }
    }
  }

  void singleLoop() async {
    isLoop = 1;
    await player.setReleaseMode(ReleaseMode.LOOP);
  }

  void multiLoop() async {
    isLoop = 2;
    await player.setReleaseMode(ReleaseMode.RELEASE);
  }

  void stopLoop() async {
    isLoop = 0;
  }

  void stopSong() async {
    int result = await player.stop();
    if (result == 1) {
      isPlaying = false;
      playingSong = null;
    }
  }
}
