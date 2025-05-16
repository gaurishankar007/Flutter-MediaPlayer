import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:player/app_initializer.dart';
import 'package:player/features/audio/views/audio_media_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();
  runApp(ProviderScope(child: const MediaPlayerApp()));
}

class MediaPlayerApp extends StatelessWidget {
  const MediaPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Media Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AudioMediaView(),
    );
  }
}
