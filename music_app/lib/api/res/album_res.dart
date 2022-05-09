import 'package:json_annotation/json_annotation.dart';

part 'album_res.g.dart';

@JsonSerializable()
class GetAlbum {
  @JsonKey(name: "_id")
  String? id;

  String? title;

  GetAlbum({
    this.id,
    this.title,
  });
  
  factory GetAlbum.fromJson(Map<String, dynamic> json) =>
      _$GetAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$GetAlbumToJson(this);
}
