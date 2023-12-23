import 'package:flutter/material.dart';

class StarIcon extends StatelessWidget {
  final IconData icon;
  const StarIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: Icon(icon, size: 50,),
    );
  }
}
