import 'package:flutter/material.dart';

import '../dashboard_view.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  final navigationIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navigationIndexNotifier,
      builder: (context, currentIndex, child) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          onTap: (index) {
            if (index == 0) {
              navigator.currentState!.pushReplacementNamed('/music');
              navigationIndexNotifier.value = 0;
            } else {
              navigator.currentState!.pushReplacementNamed('/queue');
              navigationIndexNotifier.value = 1;
            }
          },
          items: [
            BottomNavigationBarItem(
              label: "Music",
              icon: Icon(Icons.library_music_outlined),
            ),
            BottomNavigationBarItem(
              label: "Queue",
              icon: Icon(Icons.queue_music_outlined),
            ),
          ],
        );
      },
    );
  }
}
