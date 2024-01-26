/*
Currently being used to test the accounts functionality

TODO: display the users achievements

 */

import 'package:account_manger/components/test_account_tile.dart';
import 'package:account_manger/models/account_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // text controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // create new account
  void createNewAccount(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create account'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "enter name",),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(hintText: "enter category",),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: "enter username",),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "enter password",),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
                      nameController.clear();
                      categoryController.clear();
                      usernameController.clear();
                      passwordController.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(onPressed: (){
                    String newAccountName = nameController.text;
                    String newCategory = categoryController.text;
                    String newUsername = usernameController.text;
                    String newPassword = passwordController.text;

                    // save to db
                    context.read<AccountDatabase>().addAccount(newAccountName, newCategory, newUsername, newPassword);

                    // pop box
                    Navigator.pop(context);

                    // clear controller
                    nameController.clear();
                    categoryController.clear();
                    usernameController.clear();
                    passwordController.clear();


          },
              child: const Text("Save"))
        ],
      )
    );
  }

  // delete account box
  void deleteAccountBox(Account account){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to delete?"),
        actions: [
          // delete button
          MaterialButton(
            onPressed: (){
              // save to db
              context.read<AccountDatabase>().deleteAccount(account.id);

              // pop box
              Navigator.pop(context);

              setState(() {});
            },
            child: const Text("Delete"),
          ),

          // cancel button
          MaterialButton(
            onPressed: (){
              // pop box
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountDatabase = context.watch<AccountDatabase>();

    // current accounts
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createNewAccount,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
       body: _buildAccountList(),
    );
  }


  // build account list
  Widget _buildAccountList(){
    // account db
    final accountDatabase = context.watch<AccountDatabase>();

    // current accounts
    List<Account> currentAccounts = accountDatabase.currentAccounts;

    // return list of accounts UI
    return ListView.builder(
      itemCount: currentAccounts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // get each individual account
        final account = currentAccounts[index];


        // return account tile UI
        return MyAccountTile(
          account: account,
          deleteAccount: (context) => deleteAccountBox(account),
        );
      },
    );
  }
}
