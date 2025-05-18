import 'package:flutter/material.dart';

import '../../../../core/audio_player_handler.dart';

class MediaSeekerWidget extends StatelessWidget {
  final double trackHeight;
  final double thumbRadius;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;

  const MediaSeekerWidget({
    super.key,
    this.trackHeight = 2.5,
    this.thumbRadius = 6,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white54,
    this.thumbColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final audioHandler = AudioHandlerUtil.I;
    return StreamBuilder(
      stream: audioHandler.positionStream,
      builder: (context, positionSnapshot) {
        if (!positionSnapshot.hasData) return const SizedBox.shrink();

        final currentDuration = positionSnapshot.data!.inMilliseconds;
        final totalDuration =
            audioHandler.mediaItem.value?.duration?.inMilliseconds ?? 1;
        final progress = (currentDuration / totalDuration).clamp(0.0, 1.0);

        return _buildSlider(
          progress: progress,
          totalDuration: totalDuration,
          isInteractive: thumbRadius > 0,
        );
      },
    );
  }

  Widget _buildSlider({
    required double progress,
    required int totalDuration,
    required bool isInteractive,
  }) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: activeColor,
        inactiveTrackColor: inactiveColor,
        disabledActiveTrackColor: activeColor,
        disabledInactiveTrackColor: inactiveColor,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: thumbRadius,
          disabledThumbRadius: thumbRadius,
        ),
        trackHeight: trackHeight,
        thumbColor: thumbColor,
        overlayColor: Colors.transparent,
      ),
      child: Slider(
        value: progress,
        min: 0,
        max: 1,
        padding: EdgeInsets.zero,
        onChanged:
            isInteractive
                ? (value) async {
                  await AudioHandlerUtil.I.seek(
                    Duration(milliseconds: (value * totalDuration).round()),
                  );
                }
                : null,
        onChangeStart: isInteractive ? (_) => AudioHandlerUtil.I.pause() : null,
        onChangeEnd: isInteractive ? (_) => AudioHandlerUtil.I.play() : null,
      ),
    );
  }
}
