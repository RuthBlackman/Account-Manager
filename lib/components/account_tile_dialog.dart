import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../models/account_database.dart';


class AccountTileDialog extends StatelessWidget {
  final Account account;

  const AccountTileDialog({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_horiz),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 20),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      // name of account
                      Text(
                        account.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 30),
                        maxLines: 1, // maximum number of lines to display
                        overflow: TextOverflow.ellipsis,
                      ),

                      // option to edit account
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context, "/account_info_page",
                            arguments: {
                              "mode": "edit_account",
                              "account": account,
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "Edit account",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),

                      // option to delete account
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(30.0)),
                                title: const Text(
                                    'Confirm Delete',
                                    textAlign: TextAlign.center
                                ),
                                content: const Text(
                                    'Are you sure you want to delete this account?',
                                    textAlign: TextAlign.center
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Cancel the operation
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Delete account
                                      context.read<AccountDatabase>().deleteAccount(account.id);

                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Delete account",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                      // button to close dialog
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Close",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
