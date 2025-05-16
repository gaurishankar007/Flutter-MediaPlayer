import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../core/audio_player_handler.dart';

part 'audio_media_state.dart';

final audioMediaProvider = StateNotifierProvider(
  (_) => AudioMediaNotifier(audioHandler: GetIt.I<AudioPlayerHandler>()),
);

class AudioMediaNotifier extends StateNotifier<AudioMediaState> {
  final AudioPlayerHandler _audioHandler;

  AudioMediaNotifier({required AudioPlayerHandler audioHandler})
    : _audioHandler = audioHandler,
      super(AudioMediaState.empty());

  getMediaItems() async {
    final mediaItems = [
      MediaItem(
        id:
            'https://p.scdn.co/mp3-preview/ab4f8a072b5a2a5e5d4a3a2f5a2a5e5d4a3a2f5',
        album: 'Future Nostalgia',
        title: 'Don’t Start Now',
        artist: 'Dua Lipa',
        duration: const Duration(minutes: 3, seconds: 3),
        artUri: Uri.parse(
          'https://i.scdn.co/image/ab67616d0000b2732a038d3bf875d23e4aeaa84e',
        ),
        genre: 'Pop',
      ),
      MediaItem(
        id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        album: 'Moonlight Sonata',
        title: 'Piano Sonata No. 14 in C# Minor',
        artist: 'Ludwig van Beethoven',
        duration: const Duration(minutes: 6, seconds: 20),
        artUri: Uri.parse(
          'https://upload.wikimedia.org/wikipedia/commons/6/6f/Beethoven.jpg',
        ),
        genre: 'Classical',
      ),
      MediaItem(
        id: 'https://traffic.libsyn.com/secure/hubermanlab/episode1.mp3',
        album: 'Huberman Lab Podcast',
        title: 'The Science of Learning',
        artist: 'Andrew Huberman',
        duration: const Duration(hours: 2, minutes: 15),
        artUri: Uri.parse(
          'https://i1.sndcdn.com/artworks-000553896123-8m4x1a-t500x500.jpg',
        ),
        genre: 'Podcast',
      ),
    ];

    state = state.copyWith(mediaItems: mediaItems);
  }

  play(MediaItem mediaItem) {
    _audioHandler.playMediaItem(mediaItem);
  }
}
