import 'package:account_manger/colours.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: lightBlue,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(63);
}
