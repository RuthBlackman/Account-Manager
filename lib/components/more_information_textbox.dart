import 'package:account_manger/colours.dart';
import 'package:flutter/material.dart';

class MoreInformationTextbox extends StatelessWidget {
  final TextEditingController controller;

  const MoreInformationTextbox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Column(
        children: [
          const Text(
            "Which accounts, if any, can you access using this account? \n For example, "
                "you can use Facebook to login to Spotify",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 40,
            width: 200,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: greyButton,
                filled: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
