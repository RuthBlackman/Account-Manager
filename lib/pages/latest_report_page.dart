import 'package:account_manger/components/buttons/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colours.dart';
import '../models/account.dart';
import '../models/account_database.dart';

class LatestReport extends StatefulWidget {
  const LatestReport({super.key});

  @override
  State<LatestReport> createState() => _LatestReportState();
}

class _LatestReportState extends State<LatestReport> {
  // map: problem -> num accounts
  // problems: no 2fa, no password manager, password below 10 chars

  Map<String, int> problemsMap = new Map();
  List<String> problems = ["Two-factor authentication not enabled", "Password manager "
      "not storing password", "Password length below 10 characters"];

  Map<String, int> createProblemsMap() {
    problemsMap.clear();

    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    for (Account account in currentAccounts){
      // check if 2fa enabled
      if(account.incomingAccounts.where((element) => element.contains("2FA")).isEmpty){
        // check if problem is in map
        if(problemsMap.containsKey(problems[0])){
          problemsMap[problems[0]] = (problemsMap[problems[0]])! + 1;
        }else {
          problemsMap[problems[0]] = 1;
        }
      }

      // check if pwd stored in password manager
      if(account.incomingAccounts.where((element) => element.contains("Password Manager")).isEmpty){
        if(problemsMap.containsKey(problems[1])){
          problemsMap[problems[1]] = (problemsMap[problems[1]])! + 1;
        }else{
          problemsMap[problems[1]] = 1;
        }
      }

      // check pwd length
      if(account.password.length < 10){
        if(problemsMap.containsKey(problems[2])){
          problemsMap[problems[2]] = (problemsMap[problems[2]])! + 1;
        }else{
          problemsMap[problems[2]] = 1;
        }
      }
    }
    return problemsMap;

  }

  List<Widget> _buildProblemWidgets(Map<String, int> problemsMap) {
    List<Widget> widgets = [];

    problemsMap.forEach((problem, number) {
      widgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: "${number}x ", style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: problem),
            ],
          ),
          )
      )
      );
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    createProblemsMap();
    return Container(
      color: blueBackground,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              //    padding: const EdgeInsets.all(40.0),
              padding: const EdgeInsets.only(top: 40, left: 70, right: 70, bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Latest Report",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${createProblemsMap().length} problems",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ..._buildProblemWidgets(createProblemsMap())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: MyButton(
              text: "Start Scan",
              backgroundColour: Colors.white,
              fontSize: 16,
              onButtonClicked: (){
                Navigator.pushNamed(context, '/security_report');
              },
            ),
          ),
        ],
      ),
    );
  }
}
