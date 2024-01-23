import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class MyNavBar extends StatefulWidget {
  final ValueChanged<int> onTap;
  final int currentIndex;

  const MyNavBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _MyNavBarState createState() =>
      _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        DotNavigationBarItem(
          icon: Icon(Icons.home_filled),
          selectedColor: Colors.black,
        ),
        DotNavigationBarItem(
          icon: Icon(Icons.shield),
          selectedColor: Colors.black,
        ),
        DotNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          selectedColor: Colors.black,
        ),
        DotNavigationBarItem(
          icon: Icon(Icons.settings),
          selectedColor: Colors.black,
        ),
      ],
    );
  }
}
