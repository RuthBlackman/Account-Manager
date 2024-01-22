import 'package:account_manger/colours.dart';
import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({super.key});

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
                Text(
                  "Google",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: purpleBackground,
                  ),
                ),
                Text(
                  "email@google.com",
                  style: TextStyle(
                    color: Color(0xFFB8B8F3),
                  ),
                )
              ],
            ),

            // button for options
            IconButton(
              // TODO: open menu that allows the user to navigate to specific account page
                onPressed: (){},
                icon: const Icon(Icons.more_horiz)
            )
          ],
        ),
      ),
    );
  }
}
