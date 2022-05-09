import 'package:json_annotation/json_annotation.dart';
import 'album_res.dart';

part 'song_res.g.dart';

@JsonSerializable(explicitToJson: true)
class GetSong {
  @JsonKey(name: "_id")
  String? id;

  String? title;
  GetAlbum? album;
  String? music;
  int? players;
  int? likes;

  GetSong({
    this.id,
    this.title,
    this.album,
    this.music,
    this.players,
    this.likes,
  });

  factory GetSong.fromJson(Map<String, dynamic> json) =>
      _$GetSongFromJson(json);

  Map<String, dynamic> toJson() => _$GetSongToJson(this);
}
