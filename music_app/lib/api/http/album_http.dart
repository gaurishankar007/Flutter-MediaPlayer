import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:music_app/api/log_status.dart';
import 'package:music_app/api/urls.dart';

class AlbumHttp {
  final routeUrl = ApiUrls.routeUrl;
  final token = LogStatus.token;

  Future<List> getAlbums() async {
    final response = await get(
      Uri.parse(routeUrl + "view/album"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    return jsonDecode(response.body);
  }
}
