import 'package:flutter/material.dart';

import '../../../../core/audio_player_handler.dart';

class MediaProgressWidget extends StatelessWidget {
  final TextStyle? textStyle;
  final Color? progressColor;
  final Color? remainingColor;

  const MediaProgressWidget({
    super.key,
    this.textStyle,
    this.progressColor,
    this.remainingColor,
  });

  @override
  Widget build(BuildContext context) {
    final audioHandler = AudioHandlerUtil.I;
    final defaultStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontFeatures: [const FontFeature.tabularFigures()],
    );
    final style = textStyle ?? defaultStyle;

    return StreamBuilder(
      stream: audioHandler.positionStream,
      builder: (context, positionSnapshot) {
        if (!positionSnapshot.hasData) return const SizedBox.shrink();

        final currentDuration = positionSnapshot.data!;
        final totalDuration =
            audioHandler.mediaItem.value?.duration ?? Duration.zero;
        final remainingDuration = totalDuration - currentDuration;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Elapsed time
            Text(
              _formatDuration(currentDuration),
              style: style?.copyWith(color: progressColor),
            ),
            // Remaining time
            Text(
              '-${_formatDuration(remainingDuration)}',
              style: style?.copyWith(color: remainingColor),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }
}
