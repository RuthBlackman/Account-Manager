/*
  todo: fetch account problems and display here
  todo: need to split up problems into critical and other
 */

import 'package:account_manger/colours.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:account_manger/components/recommendation_tile.dart';
import 'package:account_manger/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:account_manger/models/account_database.dart';

import '../models/account.dart';

// todo: calculate report and then display issues
// need to work out how to process data into different problems and groups of problems (critical, other)

class SecurityReport extends StatefulWidget {
  const SecurityReport({super.key});

  @override
  State<SecurityReport> createState() => _SecurityReportState();
}

class _SecurityReportState extends State<SecurityReport> {
  Map<int, List<Account>> sortedScoreAccounts = new Map();
  Map<int, List<Account>> scoreAccounts = new Map();

  // TODO: add more reasons when score becomes more complicated
  List<String> waysToGetPoints = [
    "Enable Two-Factor Authentication",
    "Password should have at least 10 characters",
    "Store password with Password Manager",
  ];

  Map<Account, List<String>> recommendationAccounts = new Map();

  void createScoreAccountMap(){
    scoreAccounts.clear();
    sortedScoreAccounts.clear();

    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    for(Account account in currentAccounts){
      int score = numberOfPoints(account);

      // if map contains key of this score, add account to list
      if(scoreAccounts.containsKey(score)){
          // get list
          List<Account>? newAccounts = scoreAccounts[score];
          // add account to list
          newAccounts?.add(account);
          // set value to be updated list
          scoreAccounts[score] = newAccounts!;
      // if it doesnt, make new key value pair
      }else{
        scoreAccounts[score] = [account];
      }
    }

    // Get the keys and sort them
    List<int> sortedKeys = scoreAccounts.keys.toList()..sort();

    // Create a new map with sorted entries
    for (int key in sortedKeys) {
      sortedScoreAccounts[key] = scoreAccounts[key]!;
    }
  }

  void createRecommendationAccountMap(){
    recommendationAccounts.clear();

    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    for(Account account in currentAccounts){
      // create new key, value pair for the account
      recommendationAccounts[account] = [];


      // check if 2fa enabled
      if(account.incomingAccounts.where((element) => element.contains("2FA")).isEmpty){
        // get account's recommendations list
        List<String>? recommendations = recommendationAccounts[account];
        // add account to list
        recommendations?.add(waysToGetPoints[0]);
        // set value to be updated list
        recommendationAccounts[account] = recommendations!;
      }

      // check password length
      if(account.password.length < 10){
        List<String>? recommendations = recommendationAccounts[account];
        recommendations?.add(waysToGetPoints[1]);
        recommendationAccounts[account] = recommendations!;
      }

      // check if using password manager
      if(account.incomingAccounts.where((element) => element.contains("Password Manager")).isEmpty){
        List<String>? recommendations = recommendationAccounts[account];
        recommendations?.add(waysToGetPoints[2]);
        recommendationAccounts[account] = recommendations!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    createScoreAccountMap();
    createRecommendationAccountMap();

    return Scaffold(
      backgroundColor: blueBackground,
      appBar: const MyAppBar(title: "Security Report",),
      body: MyContainer(
        height: MediaQuery.of(context).size.height,
        isStarsContainer: false,
        children: [
          WidgetWithCustomWidth(
            widget: Column(
            children: sortedScoreAccounts.entries.map((pair) {
              int key = pair.key;
              List<Account> values = pair.value;
              return RecommendationTile(score: key, values: values, recommendationAccounts: recommendationAccounts);
            }).toList(),
          ),
          )
        ],
      ),
      // body: Padding(
      //       padding: const EdgeInsets.all(40.0),
      //       child: Container(
      //         height: 500,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(20.0),
      //               color: Colors.white,
      //         ),
      //         alignment: Alignment.center,
      //         child: SingleChildScrollView(
      //           child: Column(
      //
      //               children: sortedScoreAccounts.entries.map((pair) {
      //                 int key = pair.key;
      //                 List<Account> values = pair.value;
      //                 return RecommendationTile(score: key, values: values, recommendationAccounts: recommendationAccounts);
      //               }).toList(),
      //             ),
      //         ),
      //       ),
      //     ),
    );
  }
}
