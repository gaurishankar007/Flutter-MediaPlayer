import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/data/models/music_album.dart';

part 'music_state.dart';

final musicProvider = StateNotifierProvider((_) => MusicNotifier());

class MusicNotifier extends StateNotifier<MusicState> {
  MusicNotifier() : super(MusicState.empty()) {
    getMediaItems();
  }

  getMediaItems() async {
    final albums = [
      MusicAlbum(
        id:
            "https://rukminim3.flixcart.com/image/850/1000/xif0q/poster/u/p/n/large-hindu-god-shri-krishna-photo-poster-with-uv-textured-size-original-imagr2jbgpt3cyrh.jpeg?q=20&crop=false",
        title: "Krishna Song",
        photoUrl:
            "https://rukminim3.flixcart.com/image/850/1000/xif0q/poster/u/p/n/large-hindu-god-shri-krishna-photo-poster-with-uv-textured-size-original-imagr2jbgpt3cyrh.jpeg?q=20&crop=false",
        artistName: "Jubin Nautiyal",
        songs: [
          MediaItem(
            id:
                'https://res.cloudinary.com/gaurishankar/video/upload/v1747567805/yfkfwfwaqfyxoo8t4xrw.mp3', // Public test audio
            album:
                "https://rukminim3.flixcart.com/image/850/1000/xif0q/poster/u/p/n/large-hindu-god-shri-krishna-photo-poster-with-uv-textured-size-original-imagr2jbgpt3cyrh.jpeg?q=20&crop=false",
            title: 'Shree Krishna Govinda Hare',
            artist: 'Jubin Nautiyal',
            duration: const Duration(minutes: 2, seconds: 34),
            artUri: Uri.parse(
              'https://i.ytimg.com/vi/1qmPNot9NJs/maxresdefault.jpg',
            ),
            genre: 'Classic',
          ),
          MediaItem(
            id:
                'https://res.cloudinary.com/gaurishankar/video/upload/v1747567831/mokwscyaviy8ctqwa31o.mp3', // Public test audio
            album:
                "https://rukminim3.flixcart.com/image/850/1000/xif0q/poster/u/p/n/large-hindu-god-shri-krishna-photo-poster-with-uv-textured-size-original-imagr2jbgpt3cyrh.jpeg?q=20&crop=false",
            title: 'Tum Prem Ho',
            artist: 'Mohit Lalbani',
            duration: const Duration(minutes: 5, seconds: 2),
            artUri: Uri.parse(
              'https://i.scdn.co/image/ab67616d0000b273b12ff740610acd392264fa8c',
            ),
            genre: 'Classic',
          ),
        ],
      ),

      MusicAlbum(
        id:
            "https://img.freepik.com/free-vector/beautiful-lord-krishna-flute-peacock-feather-janmashtami-festival-card-background_1035-24234.jpg",
        title: "Krishna Flute",
        photoUrl:
            "https://img.freepik.com/free-vector/beautiful-lord-krishna-flute-peacock-feather-janmashtami-festival-card-background_1035-24234.jpg",
        artistName: "Art Beyond",
        songs: [
          MediaItem(
            id:
                'https://res.cloudinary.com/gaurishankar/video/upload/v1747567828/dmj0sc3kmaanemcqwktn.mp3', // Public test audio
            album:
                "https://img.freepik.com/free-vector/beautiful-lord-krishna-flute-peacock-feather-janmashtami-festival-card-background_1035-24234.jpg",
            title: 'The Flute of Shree Krishna',
            artist: 'Art Beyond',
            duration: const Duration(minutes: 3, seconds: 5),
            artUri: Uri.parse(
              'https://5.imimg.com/data5/SELLER/Default/2023/12/365695679/GL/DU/HU/20619026/9086614aee448043586a422bec08ced0-500x500.jpg',
            ),
            genre: 'Classic',
          ),
          MediaItem(
            id:
                'https://res.cloudinary.com/gaurishankar/video/upload/v1747568822/cwrpwbrzmrmwhn2o6kkj.mp3', // Public test audio
            album:
                "https://img.freepik.com/free-vector/beautiful-lord-krishna-flute-peacock-feather-janmashtami-festival-card-background_1035-24234.jpg",
            title: 'Enchanting Flute',
            artist: 'Kaala Bhairava',
            duration: const Duration(minutes: 1, seconds: 0),
            artUri: Uri.parse(
              'https://i.ytimg.com/vi/yRrU0zCUVJg/maxresdefault.jpg',
            ),
            genre: 'Classic',
          ),
        ],
      ),
    ];

    state = state.copyWith(albums: albums);
  }
}
