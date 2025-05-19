import 'package:flutter/material.dart';

import '../../../../core/audio_player_handler.dart';
import 'media_loop_button_widget.dart';
import 'media_play_button_widget.dart';
import 'media_shuffle_button_widget.dart';

class MediaControllerWidget extends StatelessWidget {
  const MediaControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MediaShuffleButtonWidget(iconSize: 32),
        IconButton(
          onPressed: () => AudioHandlerUtil.I.skipToPrevious(),
          icon: Icon(
            Icons.skip_previous_rounded,
            size: 40,
            color: Colors.deepPurple,
          ),
        ),
        MediaPlayButtonWidget(iconSize: 48),
        IconButton(
          onPressed: () => AudioHandlerUtil.I.skipToNext(),
          icon: Icon(
            Icons.skip_next_rounded,
            size: 40,
            color: Colors.deepPurple,
          ),
        ),
        MediaLoopButtonWidget(iconSize: 32),
      ],
    );
  }
}
