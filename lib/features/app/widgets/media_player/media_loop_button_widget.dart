import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/audio_player_handler.dart';
import '../stream_builder_widget.dart';

class MediaLoopButtonWidget extends StatelessWidget {
  final double? iconSize;
  const MediaLoopButtonWidget({super.key, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final audioHandler = AudioHandlerUtil.I;
    return StreamBuilderWidget(
      stream: audioHandler.loopModeStream,
      builder: (loopMode) {
        return IconButton(
          onPressed: () => audioHandler.setRepeatMode(_getRepeatMode(loopMode)),
          icon: Icon(
            _getLoopModeIcon(loopMode),
            size: iconSize,
            color: loopMode == LoopMode.off ? Colors.black : Colors.deepPurple,
          ),
        );
      },
    );
  }

  IconData _getLoopModeIcon(LoopMode loopMode) => switch (loopMode) {
    LoopMode.off => Icons.repeat_rounded,
    LoopMode.one => Icons.repeat_one_rounded,
    LoopMode.all => Icons.repeat_rounded,
  };

  AudioServiceRepeatMode _getRepeatMode(LoopMode loopMode) {
    switch (loopMode) {
      case LoopMode.off:
        return AudioServiceRepeatMode.all;
      case LoopMode.all:
        return AudioServiceRepeatMode.one;
      case LoopMode.one:
        return AudioServiceRepeatMode.none;
    }
  }
}
