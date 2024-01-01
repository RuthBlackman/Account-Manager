// todo: score for an account is dependent on the user's answers

import 'package:account_manger/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:account_manger/components/my_checkbox.dart';
import '../colours.dart';
import 'more_information_textbox.dart'; // Import your MyCheckbox widget

class MoreInformationDialog extends StatefulWidget {
  const MoreInformationDialog({Key? key});

  @override
  _MoreInformationDialogState createState() => _MoreInformationDialogState();
}

class _MoreInformationDialogState extends State<MoreInformationDialog> {
  bool isTFAon = false; // Add a boolean variable to track the checkbox state
  bool isEmailRegistered = false;
  bool wasPasswordGenerated = false;
  bool isPasswordStrong = false;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SingleChildScrollView(
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 20),
            child: Container(
              height: 550,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                            "Extra Information",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      MyCheckbox(
                        checkboxText: 'Have you turned on Two-Factor Authentication for this '
                            'account?',
                        value: isTFAon,
                        onChanged: (bool? value) {
                          setState(() {
                            isTFAon = value ?? false;
                          });
                        },
                      ),
                      MyCheckbox(
                        checkboxText: 'Do you have an email address registered to this account?',
                        value: isEmailRegistered,
                        onChanged: (bool? value) {
                          setState(() {
                            isEmailRegistered = value ?? false;
                          });
                        },
                      ),
                      MoreInformationTextbox(controller: controller),
                      MyCheckbox(
                        checkboxText: 'Was this password generated for you?',
                        value: wasPasswordGenerated,
                        onChanged: (bool? value) {
                          setState(() {
                            wasPasswordGenerated = value ?? false;
                          });
                        },
                      ),
                      MyCheckbox(
                        checkboxText: 'Do you believe that this password is strong?',
                        value: isPasswordStrong,
                        onChanged: (bool? value) {
                          setState(() {
                            isPasswordStrong = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  MyButton(text: "Save & Close",
                      width: 200,
                      height: 79,
                      color: greyButton,
                      onTap: (){
                        // TODO: save values so that they can be retrieved

                        // close dialog
                        Navigator.pop(context);
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
