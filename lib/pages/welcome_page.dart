import 'package:account_manger/colours.dart';
import 'package:account_manger/components/buttons/my_button.dart';
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

                    MyButton(text: "Continue", fontSize: 20, backgroundColour: lightBlue, onButtonClicked: (){Navigator.pushReplacementNamed(context, '/first_time_page');})
                  ]
              )
          )
      ),

    );
  }
}
