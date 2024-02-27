import 'package:flutter/material.dart';

import '../models/account.dart';

class AchievementTile extends StatefulWidget {
  final int total; // total accounts
  final int star; // number of stars
  final List<Account> accounts;
  const AchievementTile({super.key, required this.total, required this.star, required this.accounts});

  @override
  State<AchievementTile> createState() => _AchievementTileState();
}

class _AchievementTileState extends State<AchievementTile> {
  bool showAccounts = false;

  void changeShowAccounts(){
    setState(() {
      showAccounts = !showAccounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeShowAccounts(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),

          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < widget.star; i++) Icon(Icons.star),
                      ],
                    ),
                    widget.total > 1
                        ? Expanded(child: Center(child: Text("${widget.total} accounts with ${widget.star} stars!", style: TextStyle(fontWeight: FontWeight.bold),)))
                        : Expanded(child: Center(child: Text("${widget.total} account with ${widget.star} stars!", style: TextStyle(fontWeight: FontWeight.bold),)))
                  ],
                ),
                showAccounts
                    ?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text("Accounts:", style: TextStyle(fontWeight: FontWeight.bold),),
                      Column(
                        children:
                        widget.accounts.map((value) => Text(value.name,)).toList(),
                      ),
                    ],
                  ),
                )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
