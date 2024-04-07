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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DotNavigationBar(
        itemPadding: const EdgeInsets.all(16),
        marginR: const EdgeInsets.symmetric(horizontal:40, vertical: 0),
        paddingR: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),

        currentIndex: widget.currentIndex,
        onTap: widget.onTap,

        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.shield),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.emoji_events),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.settings),
            selectedColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
