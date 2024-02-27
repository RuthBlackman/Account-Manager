/*
  todo: fetch account problems and display here
  todo: need to split up problems into critical and other
 */

import 'package:account_manger/colours.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_container.dart';
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

  
  void createAccountScoreMap(){
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

    // print(sorted_score_accounts);
  }

  @override
  Widget build(BuildContext context) {
    createAccountScoreMap();
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

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Score: $key", style: const TextStyle(fontWeight: FontWeight.bold),),
                    Column(
                      children: values.map((value) => Text(value.name)).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          )
        ],
      ),
    );
  }
}
