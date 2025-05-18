part of 'music_notifier.dart';

class MusicState {
  final List<MusicAlbum> albums;

  const MusicState({required this.albums});

  const MusicState.empty() : this(albums: const []);

  MusicState copyWith({List<MusicAlbum>? albums}) {
    return MusicState(albums: albums ?? this.albums);
  }
}
