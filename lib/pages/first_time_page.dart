import 'package:account_manger/colours.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_button.dart';
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
      body: Container(
        child: MyContainer(
          isStarsContainer: false,
          height: 800,
          children: [
            WidgetWithCustomWidth(
              widget: const Column(
                children: [
                  MyText(text: "Welcome!", size: 30),
                  MyText(text: "Get started with the app by adding your account details.", size: 20),
                  MyText(text: "Gain points by making your account more secure, e.g generating"
                      " a password and turning on two-factor authentication.", size: 20),
                  MyText(text: "Earn stars based on how much information you record for your "
                      "accounts.", size: 20),
                ],
              ),
            ),
            WidgetWithCustomWidth(widget: const SizedBox(height: 30)),

            WidgetWithCustomWidth(
              widget: MyButton(
                  text: "Continue",
                  width: 80,
                  height: 75,
                  color: greyButton,
                  onTap: () {
                    Navigator.pushNamed(context, '/account_info_page');
                  }
              ),
              width: 160,
            ),

            WidgetWithCustomWidth(widget: const SizedBox(height: 20)),

            WidgetWithCustomWidth(
              widget: MyButton(
                text: "Privacy Policy",
                width: 80,
                height: 75,
                color: greyButton,
                onTap: (){},
              ),
              width: 160,
            )
          ],
        ),
      ),
    );
  }
}
