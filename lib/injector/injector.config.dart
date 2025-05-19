// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_session/audio_session.dart' as _i57;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:just_audio/just_audio.dart' as _i501;
import 'package:player/core/audio_player_handler.dart' as _i928;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initialize({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appAudioHandlerModule = _$AppAudioHandlerModule();
    await gh.factoryAsync<_i57.AudioSession>(
      () => appAudioHandlerModule.audioSession,
      preResolve: true,
    );
    gh.lazySingleton<_i501.AudioPlayer>(
      () => appAudioHandlerModule.audioPlayer,
    );
    gh.lazySingleton<_i928.AudioPlayerHandler>(
      () => _i928.AudioPlayerHandler(
        audioPlayer: gh<_i501.AudioPlayer>(),
        audioSession: gh<_i57.AudioSession>(),
      ),
    );
    return this;
  }
}

class _$AppAudioHandlerModule extends _i928.AppAudioHandlerModule {}
