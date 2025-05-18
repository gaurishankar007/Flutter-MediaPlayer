import 'package:flutter/material.dart';

import '../../../../core/audio_player_handler.dart';
import '../stream_builder_widget.dart';

class MediaPlayButtonWidget extends StatelessWidget {
  final double? iconSize;
  final Color? iconColor;

  const MediaPlayButtonWidget({super.key, this.iconSize, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return StreamBuilderWidget(
      stream: AudioHandlerUtil.I.playingStream,
      builder: (playing) {
        return IconButton(
          onPressed: () async {
            if (playing) {
              await AudioHandlerUtil.I.pause();
            } else {
              await AudioHandlerUtil.I.play();
            }
          },
          icon: Icon(
            playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: iconSize,
            color: iconColor ?? Colors.deepPurple,
          ),
        );
      },
    );
  }
}
