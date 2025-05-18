import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/views/dashboard_view.dart';
import '../../../../app/widgets/play_button/playing_icon_widget.dart';
import '../../../notifiers/music_notifier.dart';

class MusicAlbumListWidget extends ConsumerWidget {
  const MusicAlbumListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(musicProvider);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.albums.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final album = state.albums[index];
        return InkWell(
          onTap:
              () =>
                  navigator.currentState!.pushNamed("/album", arguments: album),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(102),
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Stack(
                    children: [
                      Image.network(
                        album.photoUrl,
                        height: double.maxFinite,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => SizedBox.shrink(),
                      ),
                      PlayingIconWidget(identifier: album.id),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        album.artistName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
