import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_navbar.dart';
import 'package:account_manger/pages/home_page.dart';
import 'package:account_manger/pages/profile_page.dart';
import 'package:account_manger/pages/accounts_page.dart';
import 'package:account_manger/pages/settings_page.dart';
import 'package:flutter/material.dart';

class Routing extends StatefulWidget {
  const Routing({super.key});

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  int _currentIndex = 0;

  void navigateNavBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<String> _names = [
    "Home",
    "Accounts",
    "Profile",
    "Settings",
  ];

  StatefulWidget getPage(index){
    if(index ==0){
      return HomePage();
    }else if(index == 1){
      return AccountsPage();
    }else if (index ==2){
      return ProfilePage();
    }else{
      return SettingsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar( title: _names[_currentIndex],),
      body: Center(
        child: getPage(_currentIndex),
      ),
      bottomNavigationBar: MyNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
