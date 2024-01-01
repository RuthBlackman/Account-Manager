import 'package:account_manger/colours.dart';
import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final String checkboxText;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const MyCheckbox({
    Key? key,
    required this.checkboxText,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CheckboxListTile(
        title: Text(
            widget.checkboxText,
          textAlign: TextAlign.center,
        ), // Display checkboxText as the title
        value: widget.value,
        onChanged: widget.onChanged,
        activeColor: greyButton,
        checkColor: Colors.black,
      ),
    );
  }
}
