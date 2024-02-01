import 'package:flutter/material.dart';

import '../../colours.dart';

class ButtonWithIcon extends StatefulWidget {
  final IconData icon;
  final String text;
  final void Function() onButtonClicked;
  const ButtonWithIcon({super.key, required this.icon, required this.text, required this.onButtonClicked});

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {

  late IconData icon;
  late String text;

  @override
  void initState() {
    super.initState();
    icon = widget.icon;
    text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20.0),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            backgroundColor: greyButton,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: (){
            widget.onButtonClicked();

          },
          child: Column(
            children: [
              Text(
                widget.text,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Icon(widget.icon),
              ),
            ],
          )
      ),
    );
  }
}
