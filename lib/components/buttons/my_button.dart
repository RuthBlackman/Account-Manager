import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color backgroundColour;
  final void Function() onButtonClicked;

  const MyButton({super.key, required this.text, required this.fontSize, required this.backgroundColour, required this.onButtonClicked});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late String text;
  late double size;
  late Color colour;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    size = widget.fontSize;
    colour = widget.backgroundColour;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          backgroundColor: colour,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          // fixedSize: Size(1, 50)
        ),
        onPressed: (){
          widget.onButtonClicked();
        },
        child: Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size),
        ),
      ),
    );
  }
}
