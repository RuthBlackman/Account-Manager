import 'package:account_manger/colours.dart';
import 'package:account_manger/components/account_name.dart';
import 'package:account_manger/components/buttons/button_with_icon.dart';
import 'package:account_manger/components/category_dropdown.dart';
import 'package:account_manger/components/more_information_dialog.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_button.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:account_manger/components/my_textfield.dart';
import 'package:account_manger/components/star_icon.dart';
import 'package:account_manger/models/test_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../models/account_database.dart';

class AccountInfoPage extends StatelessWidget {
  AccountInfoPage({super.key});

  // text editing controllers
  final TextEditingController accountController = TextEditingController(text: "Account");
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //TODO: if first time user, display next button, so they can add more accounts
  final bool firstTimeUer = true; // hardcoded for now

  void _showDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return MoreInformationDialog();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // check whether user is editing/viewing an account or creating a new one
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    print(arguments);

    String category = '';
    Account? account;
    String accountName = 'Account';

    if(arguments != null ){
      String? operation = arguments['mode'] ?? null ;
      // Account? account = arguments['account'] ?? null;
      account = arguments['account'] ?? null;


      print(operation);
      print(account);

      if(operation == "add_account"){
        print("user is adding an account!");
      }else if (operation == "edit_account" && account != null) {
        print("user is editing ${account.name} !");

        accountName = account.name;

        // edit the controllers
        accountController.text = accountName;
        usernameController.text = account.username;
        passwordController.text = account.password;

        // edit category
        category = account.category;

      }else{
        print("error, ${operation}, ${account}");
      }
    }

    // int howManyStars(){
    //
    // }

    void categoryChanged(String newCategory){
      category = newCategory;
    }

    void accountNameChanged(String newAccountName){
      accountName = newAccountName;
    }

    void saveButtonClicked(){
      print("SAve");

      // get the fields
      // String accountName = accountController.text;
      String accountCategory = category;
      String accountUsername = usernameController.text;
      String accountPassword = passwordController.text;

      // todo: need to get fields in 'enter more info'

      if(category == ""){
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text('Account must have a category.'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if (accountName == 'Account') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text('Please tap on \'Account\' to create a name for the account.'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        // if account exists, simply edit it
        if(account != null){
          context.read<AccountDatabase>().editAccount(account.id, accountName, accountCategory, accountUsername, accountPassword);
        }else{ // account is null so create new account
          context.read<AccountDatabase>().addAccount(accountName, accountCategory, accountUsername, accountPassword);
        }

        // return to accounts page
        Navigator.pushReplacementNamed(context, '/routing');
      }
    }

    void discardButtonClicked(){
      print("discard");
      Navigator.pushReplacementNamed(context, '/routing');
    }

    void nextButtonClicked(){
      print("next");

      // TODO: clear all fields
    }

    return Scaffold(
      appBar: const MyAppBar(title: "Account Information"),
      backgroundColor: blueBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // score
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center, // need container within container to center align
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: green,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "0",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )
                  ),
                ),
              ),
            ),

            // custom container with account functionality
            MyContainer(
              isStarsContainer: false,
              height: 500,
              children: [
                // account name
                WidgetWithCustomWidth(widget: AccountNameWidget( accountName: accountController.text, onAccountNameChanged: accountNameChanged)),

                // category
                WidgetWithCustomWidth(
                  widget: CategoryDropdown(category: category, onCategoryChanged: categoryChanged),
                  width: 250,
                ),

                // username
                WidgetWithCustomWidth(
                    width: 250,
                    widget: MyTextField(
                      hintText: "Username",
                      obscureText: false,
                      controller: usernameController,
                    )
                ),

                // password
                WidgetWithCustomWidth(
                    width: 250,
                    widget: MyTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: passwordController,
                    )
                ),

                // open dialog to enter more information
                WidgetWithCustomWidth(
                  widget: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: MyButton(
                      text: "Enter More Info",
                      width: 100,
                      height: 75,
                      color: greyButton,
                      onTap: (){
                        _showDialog(context);
                      },
                    ),
                  ),
                  width: 200,
                ),

                WidgetWithCustomWidth(
                    widget: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // save button
                        ButtonWithIcon(icon: Icons.add, text: "Save", onButtonClicked: saveButtonClicked,),

                        // discard button
                        ButtonWithIcon(icon: Icons.exit_to_app, text: "Discard", onButtonClicked: discardButtonClicked,),

                        // next button
                        if (firstTimeUer) ButtonWithIcon(icon: Icons.arrow_forward, text: "Next", onButtonClicked: nextButtonClicked,),
                      ],
                    )
                ),
              ],
            ),

            // stars
            MyContainer(
              height: 75,
              isStarsContainer: true,
              children: [
                WidgetWithCustomWidth(
                    widget: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StarIcon(icon: Icons.star),
                        StarIcon(icon: Icons.star),
                        StarIcon(icon: Icons.star),
                        StarIcon(icon: Icons.star),
                      ],
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

