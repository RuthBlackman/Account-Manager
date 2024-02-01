import 'package:flutter/material.dart';

class AccountNameWidget extends StatefulWidget {
  final String accountName;
  final void Function(String) onAccountNameChanged;
  const AccountNameWidget({Key? key, required this.accountName, required this.onAccountNameChanged}) : super(key: key);

  @override
  _AccountNameWidgetState createState() => _AccountNameWidgetState();
}

class _AccountNameWidgetState extends State<AccountNameWidget> {
  bool isEditing = false;
  late TextEditingController accountNameController;
  late String accountName;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    accountName = widget.accountName;
    accountNameController = TextEditingController(text: accountName);
    focusNode = FocusNode();
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
          focusNode.requestFocus(); // give focus to TextFormField in _editableText()
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
      focusNode: focusNode,
      style: const TextStyle(
        fontSize: 30,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onEditingComplete: () {
        setState(() {
          isEditing = false;
          widget.onAccountNameChanged(accountNameController.text);
          accountName = accountNameController.text;
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
      maxLines: 1, // maximum number of lines to display
      overflow: TextOverflow.ellipsis,
    );
  }
}
