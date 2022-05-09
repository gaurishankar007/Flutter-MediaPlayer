// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSong _$GetSongFromJson(Map<String, dynamic> json) => GetSong(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      album: json['album'] == null
          ? null
          : GetAlbum.fromJson(json['album'] as Map<String, dynamic>),
      music: json['music'] as String?,
      players: json['players'] as int?,
      likes: json['likes'] as int?,
    );

Map<String, dynamic> _$GetSongToJson(GetSong instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'album': instance.album?.toJson(),
      'music': instance.music,
      'players': instance.players,
      'likes': instance.likes,
    };
