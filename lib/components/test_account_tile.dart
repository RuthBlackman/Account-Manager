/*
FOR TESTING PURPOSES:
- Tile for showing account and option for deleting it
- To be removed at a later date
 */

import 'package:flutter/material.dart';

import '../models/account.dart';

class MyAccountTile extends StatelessWidget {
  final Account account;
  final void Function(BuildContext)? deleteAccount;

  const MyAccountTile({
    super.key,
    required this.account,
    required this.deleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    print("${account.name} ${account.incomingAccounts}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: GestureDetector(
          onTap: () {
            deleteAccount!(context);
          },
          // Account tile
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // text
                Text(
                  account.name,
                ),
                Text(
                  account.category,
                ),
                Text(
                  account.username,
                ),
                Text(
                  account.password,
                ),
                // ListView.builder(
                //   itemCount: account.incomingAccounts.length,
                //   itemBuilder: (context, index){
                //     return ListTile(
                //       title: Text(account.incomingAccounts[index]),
                //     );
                //   },
                // )
              ],

            ),
          ),
        ),
      );
  }
}