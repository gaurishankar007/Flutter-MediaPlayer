// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:just_audio/just_audio.dart' as _i501;
import 'package:player/core/audio_player_handler.dart' as _i928;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initialize({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appAudioHandlerModule = _$AppAudioHandlerModule();
    gh.lazySingleton<_i501.AudioPlayer>(() => appAudioHandlerModule.player);
    gh.lazySingleton<_i928.AudioPlayerHandler>(
      () => _i928.AudioPlayerHandler(
        audioPlayer: gh<_i501.AudioPlayer>(),
        miniAudioPlayer: gh<_i501.AudioPlayer>(),
      ),
    );
    return this;
  }
}

class _$AppAudioHandlerModule extends _i928.AppAudioHandlerModule {}
