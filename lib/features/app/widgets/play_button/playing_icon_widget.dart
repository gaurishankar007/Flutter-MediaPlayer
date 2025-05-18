import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifiers/audio/audio_queue_notifier.dart';

class PlayingIconWidget extends ConsumerWidget {
  /// Identify whether this media (whose id is the identifier) is being played or not
  final String identifier;
  final double? iconSize;

  const PlayingIconWidget({super.key, required this.identifier, this.iconSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaItem = ref.watch(
      audioQueueProvider.select((state) => state.mediaItem),
    );

    // If the identifier is from the current media item or playlist
    if (mediaItem?.album == identifier || mediaItem?.id == identifier) {
      return Icon(Icons.bar_chart_rounded, color: Colors.green, size: iconSize);
    }

    return const SizedBox.shrink();
  }
}
