import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;

  const MyText({
    super.key,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size,
        ),
      ),
    );
  }
}
