import 'package:audio_service/audio_service.dart';

import 'core/audio_player_handler.dart';
import 'injector/injector.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    initializeDependencies();
    await AudioService.init(
      builder: () => AudioHandlerUtil.I,
      config: AudioServiceConfig(
        androidNotificationChannelId: 'app.media.player.channel.audio',
        androidNotificationChannelName: 'Music playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
  }
}
