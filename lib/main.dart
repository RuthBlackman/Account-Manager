import 'package:account_manger/pages/account_info_page.dart';
import 'package:account_manger/pages/first_time_page.dart';
import 'package:account_manger/pages/welcome_page.dart';
import 'package:account_manger/theme/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      theme: lightMode,
        routes: {
          '/welcome_page':(context) => const WelcomePage(),
          '/first_time_page':(context) => const FirstTimePage(),
          '/account_info_page':(context) => AccountInfoPage(),
        }
    );
  }

}
