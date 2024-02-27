/*
Currently being used to test the accounts functionality

TODO: display the users achievements

 */

import 'package:account_manger/components/achievement_tile.dart';
import 'package:account_manger/components/test_account_tile.dart';
import 'package:account_manger/models/account_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colours.dart';
import '../components/my_appbar.dart';
import '../components/my_container.dart';
import '../helpers/helpers.dart';
import '../models/account.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map<int, List<Account>> sortedStarAccounts = new Map();
  Map<int, List<Account>> starAccounts = new Map();


  void createAccountScoreMap(){
    starAccounts.clear();
    sortedStarAccounts.clear();

    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    for(Account account in currentAccounts){
      int stars = numberOfStars(account);

      // if map contains key of this stars, add account to list
      if(starAccounts.containsKey(stars)){
        // get list
        List<Account>? newAccounts = starAccounts[stars];
        // add account to list
        newAccounts?.add(account);
        // set value to be updated list
        starAccounts[stars] = newAccounts!;
        // if it doesnt, make new key value pair
      }else{
        starAccounts[stars] = [account];
      }
    }

    // Get the keys and sort them
    List<int> sortedKeys = starAccounts.keys.toList()..sort();

    // Create a new map with sorted entries
    for (int key in sortedKeys) {
      sortedStarAccounts[key] = starAccounts[key]!;
    }

    // print(sorted_stars_accounts);
  }

  @override
  Widget build(BuildContext context) {
    createAccountScoreMap();
    return Scaffold(
      backgroundColor: blueBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: sortedStarAccounts.entries.map((pair) {
            int key = pair.key;
            List<Account> values = pair.value;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AchievementTile(total: values.length, star: key, accounts: values)
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}
