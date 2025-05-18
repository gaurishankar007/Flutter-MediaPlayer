import 'package:flutter/material.dart';

import '../../music/views/album/album_view.dart';
import '../../music/views/music/music_view.dart';
import '../../music/views/queue/queue_view.dart';
import '../data/models/music_album.dart';
import '../widgets/media_player/media_player_widget.dart';
import 'widgets/navigation_bar_widget.dart';

final navigator = GlobalKey<NavigatorState>();

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        key: navigator,
        initialRoute: '/music',
        onGenerateRoute: _getRoutes,
      ),
      floatingActionButton: MediaPlayerWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBarWidget(),
    );
  }

  RouteFactory? get _getRoutes => (settings) {
    final route = settings.name;
    final argument = settings.arguments;

    switch (route) {
      case '/music':
        return _getPageRoute(MusicView());
      case '/album':
        return _getPageRoute(AlbumView(album: argument as MusicAlbum));
      case '/queue':
        return _getPageRoute(QueueView());
      default:
        return _getPageRoute(Center(child: Text("Page Not Found")));
    }
  };

  MaterialPageRoute _getPageRoute(Widget view) =>
      MaterialPageRoute(builder: (context) => view);
}
