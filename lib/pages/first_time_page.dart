import 'package:account_manger/colours.dart';
import 'package:account_manger/components/buttons/my_button.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:account_manger/components/my_text.dart';
import 'package:flutter/material.dart';

class FirstTimePage extends StatelessWidget {
  const FirstTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Account Information',),
      backgroundColor: blueBackground,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Column(
                children: [
                  MyText(text: "Welcome!", size: 30),
                  MyText(text: "Get started with the app by adding your account details.", size: 20),
                  MyText(text: "Gain points by making your account more secure, e.g generating"
                      " a password and turning on two-factor authentication.", size: 20),
                  MyText(text: "Earn stars based on how much information you record for your "
                      "accounts.", size: 20),
                ],
              ),

              const SizedBox(height: 30),

              MyButton(
                text: "Continue",
                backgroundColour: greyButton,
                fontSize: 16,
                onButtonClicked: (){
                  Navigator.pushReplacementNamed(
                    context,  "/account_info_page",
                    arguments: {
                      "mode": "add_account",
                      "account": null,
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              MyButton(
                text: "Privacy Policy",
                backgroundColour: greyButton,
                fontSize: 16,
                onButtonClicked: (){},
              ),

            ],
          ),
        ),
      ),
    );
  }
}
