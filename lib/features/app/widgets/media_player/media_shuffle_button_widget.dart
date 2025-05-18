import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/audio_player_handler.dart';
import '../stream_builder_widget.dart';

class MediaShuffleButtonWidget extends StatelessWidget {
  final double? iconSize;
  const MediaShuffleButtonWidget({super.key, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final audioHandler = AudioHandlerUtil.I;
    return StreamBuilderWidget(
      stream: audioHandler.shuffleModeStream,
      builder: (shuffleModeEnabled) {
        return IconButton(
          onPressed:
              () => audioHandler.setShuffleMode(
                shuffleModeEnabled
                    ? AudioServiceShuffleMode.none
                    : AudioServiceShuffleMode.all,
              ),
          icon: Icon(
            Icons.shuffle_rounded,
            size: iconSize,
            color: shuffleModeEnabled ? Colors.deepPurple : Colors.black,
          ),
        );
      },
    );
  }
}
