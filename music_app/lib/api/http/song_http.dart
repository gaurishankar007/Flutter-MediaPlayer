import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:music_app/api/log_status.dart';
import 'package:music_app/api/res/song_res.dart';
import 'package:music_app/api/urls.dart';

class SongHttp {
  final routeUrl = ApiUrls.routeUrl;
  final token = LogStatus.token;

  Future<List<GetSong>> getSongs(String albumId) async {
    final response = await post(
      Uri.parse(routeUrl + "view/song"),
      body: {"albumId": albumId},
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    List resSongs = jsonDecode(response.body);

    if (resSongs.isEmpty) {
      return List.empty();
    }

    return resSongs.map((e) => GetSong.fromJson(e)).toList();
  }
}
