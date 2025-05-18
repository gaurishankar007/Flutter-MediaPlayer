import 'package:audio_service/audio_service.dart';

class MusicAlbum {
  final String id;
  final String title;
  final String photoUrl;
  final String artistName;
  final List<MediaItem> songs;

  MusicAlbum({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.artistName,
    required this.songs,
  });

  MusicAlbum.empty()
    : id = '',
      title = '',
      photoUrl = '',
      artistName = '',
      songs = [];
}
