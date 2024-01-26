import 'package:account_manger/colours.dart';
import 'package:account_manger/components/account_tile_dialog.dart';
import 'package:flutter/material.dart';

import '../models/account.dart';

class AccountTile extends StatelessWidget {
  final Account account;
  const AccountTile({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            // logo
            Icon(Icons.account_circle_sharp),

            // column for name and email address
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8.0),
                  child: Container(
                    width: 200, // Set a maximum width for the container
                    child: Text(
                      account.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: purpleBackground,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8.0),
                  child: Container(
                    width: 200, // Set a maximum width for the container
                    child: Text(
                      account.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB8B8F3),
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),

            // button for options
            AccountTileDialog(account: account),
          ],
        ),
      ),
    );
  }
}
