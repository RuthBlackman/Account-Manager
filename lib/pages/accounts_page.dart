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
  String searchText = "";

  List<String> categories = [];
  List<String> selectedCategories = [];

  @override
  void initState(){
    Provider.of<AccountDatabase>(context, listen: false).readAccounts();
    super.initState();
  }

  List<Account> filterAccounts(List<Account> unfilteredAccounts){
    List<Account> filteredAccounts = [];

    List<Account> possibleSearchAccounts = [];
    List<Account> possibleCategoryAccounts = [];

    if(searchText.length <2 && selectedCategories.isEmpty){
      return unfilteredAccounts;
    }

    if(searchText.length >1 && selectedCategories.isEmpty){
      for(Account a in unfilteredAccounts){
        if(searchText.length > 1){
          if(a.name.toLowerCase().contains(searchText)){
            filteredAccounts.add(a);
          }
        }
      }
    }

    if(searchText.length < 2 && selectedCategories.isNotEmpty){
      for(Account a in unfilteredAccounts){
          if(selectedCategories.contains(a.category)){
            filteredAccounts.add(a);
          }
      }
    }

    if(searchText.length >1 && selectedCategories.isNotEmpty){
      for(Account a in unfilteredAccounts){
        if(searchText.length > 1){
          if(a.name.toLowerCase().contains(searchText)){
            possibleSearchAccounts.add(a);
          }
        }
      }

      for(Account a in possibleSearchAccounts){
        if(selectedCategories.isNotEmpty){
          if(selectedCategories.contains(a.category)){
            possibleCategoryAccounts.add(a);
          }
        }
      }

      possibleSearchAccounts.removeWhere((item) => !possibleCategoryAccounts.contains(item));
      return possibleSearchAccounts;

    }
    return filteredAccounts;
  }

  List<String> getCategories(){
    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = (accountDatabase.currentAccounts);
    List<String> accountCategories = [];

    for(Account a in currentAccounts){
      if(!accountCategories.contains(a.category)){
        accountCategories.add(a.category);
      }
    }

    return accountCategories;
  }

  @override
  Widget build(BuildContext context) {
    categories = getCategories();

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
                        onChanged: (String x){
                          setState(() {
                            searchText = x;
                          });
                        },
                        trailing: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                FocusManager.instance.primaryFocus?.unfocus();
                              });
                            },
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.filter_list),
                            onSelected: (String cat){
                              setState(() {
                                if(selectedCategories.contains(cat)){
                                  selectedCategories.removeWhere((item) => item == cat);
                                }else{
                                  selectedCategories.add(cat);
                                }

                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return categories.map((String category) {
                                return CheckedPopupMenuItem<String>(
                                  value: category,
                                  checked: selectedCategories.contains(category) ? true: false,
                                  child: Text(category),
                                );
                              }).toList();
                            },
                          )
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

              Expanded(child: _buildAccountList(),),
            ]
        )
    );
  }

  Widget _buildAccountList(){
    final accountDatabase = context.watch<AccountDatabase>();
    List<Account> currentAccounts = filterAccounts(accountDatabase.currentAccounts);

    return ListView.builder(
        itemCount: currentAccounts.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          final account = currentAccounts[index];
          return AccountTile(account: account);
        }
    );
  }
}
