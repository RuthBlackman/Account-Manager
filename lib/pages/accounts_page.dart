import 'package:account_manger/components/account_tile.dart';
import 'package:account_manger/models/account_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colours.dart';
import '../models/account.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState(){
    Provider.of<AccountDatabase>(context, listen: false).readAccounts();
    super.initState();
  }


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
                  onTap: (){
                    Navigator.pushReplacementNamed(
                      context,  "/account_info_page",
                      arguments: {
                        "mode": "add_account",
                        "account": null,
                      },
                    );
                  },
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
              _buildAccountList(),
            ]
        )
    );
  }

  Widget _buildAccountList(){
    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    return ListView.builder(
      itemCount: currentAccounts.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        final account = currentAccounts[index];

        print(account.name);

        return AccountTile(account: account);
      }
    );
  }
}
