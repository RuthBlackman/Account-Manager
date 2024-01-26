import 'package:flutter/material.dart';

class AccountNameWidget extends StatefulWidget {
  final String accountName;
  const AccountNameWidget({Key? key, required this.accountName}) : super(key: key);

  @override
  _AccountNameWidgetState createState() => _AccountNameWidgetState();
}

class _AccountNameWidgetState extends State<AccountNameWidget> {
  bool isEditing = false;
  late TextEditingController accountNameController;

  @override
  void initState() {
    super.initState();
    accountNameController = TextEditingController(text: widget.accountName);
  }

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
      controller: accountNameController,
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
      widget.accountName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30,
      ),
      maxLines: 1, // maximum number of lines to display
      overflow: TextOverflow.ellipsis,
    );
  }
}
