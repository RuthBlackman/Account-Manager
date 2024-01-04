import 'package:flutter/material.dart';

class AccountNameWidget extends StatefulWidget {
  const AccountNameWidget({super.key});

  @override
  _AccountNameWidgetState createState() => _AccountNameWidgetState();
}

class _AccountNameWidgetState extends State<AccountNameWidget> {
  bool isEditing = false;
  String accountName = 'Account'; // todo: fetch account name

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isEditing = true;
            });
          },
          child: isEditing ? _editableText() : _staticText(),
        ),
      );
  }

  // user is editing, so return textformfield
  Widget _editableText() {
    return TextFormField(
      initialValue: accountName,
      onChanged: (newValue) {
        setState(() {
          accountName = newValue;
        });
      },
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onEditingComplete: () {
        setState(() {
          isEditing = false;
        });
      },
    );
  }

  // user is not editing, so just show a Text widget with the account name
  Widget _staticText() {
    return Text(
      accountName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }
}
