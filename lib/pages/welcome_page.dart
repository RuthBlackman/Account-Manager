import 'package:account_manger/colours.dart';
import 'package:account_manger/components/my_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleBackground,
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(25.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Image.asset('assets/logo.png'),

                  const SizedBox(height: 25),

                  // button
                  MyButton(
                      text: "Continue",
                      width: 127,
                      height: 67,
                      color: lightBlue,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/first_time_page');
                      }
                    )


                ]
            )
        )
      ),

    );
  }
}
