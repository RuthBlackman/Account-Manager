/*
  todo: fetch account problems and display here
  todo: need to split up problems into critical and other
 */

import 'package:account_manger/colours.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:flutter/material.dart';

// todo: calculate report and then display issues
// need to work out how to process data into different problems and groups of problems (critical, other)

class SecurityReport extends StatelessWidget {
  const SecurityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBackground,
      appBar: MyAppBar(title: "Security Report",),
      body: MyContainer(
        height: MediaQuery.of(context).size.height,
        isStarsContainer: false,
        children: [
          WidgetWithCustomWidth(
              widget: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Critical problems",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              )),
          WidgetWithCustomWidth(
              widget: const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Reused Password:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        "password1",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Affected Accounts:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        "Amazon, Google",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Recommendation:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        "Change your password for these accounts to something unique",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          WidgetWithCustomWidth(
              widget: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Other problems",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              )
          ),
          WidgetWithCustomWidth(
              widget: const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "MFA not turned on:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Affected Accounts:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        "Amazon, Google",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Recommendation:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        "Turn on MFA for these accounts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

        ],
      ),
    );
  }
}
