import 'package:account_manger/components/my_appbar.dart';
import 'package:flutter/material.dart';

class FirstTimePage extends StatelessWidget {
  const FirstTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Account Information',),
    );
  }
}
