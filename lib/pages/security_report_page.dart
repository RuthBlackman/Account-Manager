/*
  todo: fetch account problems and display here
  todo: need to split up problems into critical and other
 */

import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:flutter/material.dart';

class SecurityReport extends StatelessWidget {
  const SecurityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Security Report",),
      body: MyContainer(
        height: 500,
        isStarsContainer: false,
        children: [
          WidgetWithCustomWidth(
              widget: Text(
                "Critical problems"
              )),
          WidgetWithCustomWidth(
              widget: Text(
                "Other problems"
              ))

        ],
      ),
    );
  }
}
