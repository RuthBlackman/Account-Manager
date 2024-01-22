import 'package:account_manger/components/account_tile.dart';
import 'package:account_manger/components/my_button.dart';
import 'package:flutter/material.dart';

import '../colours.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: blueBackground,
        width: MediaQuery.of(context).size.width,
        child: Column(
            children: [
              // search bar, button, filter
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                    width: 350,
                    height: 50,
                    child: SearchBar(
                        backgroundColor: MaterialStateProperty.all(
                            greyButton
                        ),
                        controller: searchController,
                        hintText: "Search...",
                        elevation: MaterialStateProperty.all(0),
                        trailing: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              print('Search ${searchController.text}' );
                              // TODO: filter accounts based on search text
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              // TODO: fetch categories and display them here
                            },
                          ),
                        ]
                    )
                ),
              ),

              // add account button
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                  ),
                ),
              ),

              // list of accounts
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TODO: get all accounts and create tile for each one
                      // pass Account object into tile, and then display account name and username
                      AccountTile(),
                      AccountTile(),
                      AccountTile(),
                      AccountTile(),
                      AccountTile(),
                      AccountTile(),
                      AccountTile(),
                      AccountTile(),
                    ],
                  ),
                ),
              )
            ]
        )
    );
  }
}
