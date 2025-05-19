import 'core/audio_player_handler.dart';
import 'injector/injector.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    await initializeDependencies();
    await AudioHandlerUtil.I.initialize();
  }
}
