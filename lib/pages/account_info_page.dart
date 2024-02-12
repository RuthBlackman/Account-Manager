import 'package:account_manger/colours.dart';
import 'package:account_manger/components/account_name.dart';
import 'package:account_manger/components/buttons/button_with_icon.dart';
import 'package:account_manger/components/buttons/my_button.dart';
import 'package:account_manger/components/category_dropdown.dart';
import 'package:account_manger/components/more_information_dialog.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:account_manger/components/my_textfield.dart';
import 'package:account_manger/components/star_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../models/account_database.dart';

class AccountInfoPage extends StatefulWidget {
  AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  // text editing controllers
  final TextEditingController accountController = TextEditingController(text: "Account");
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //TODO: if first time user, display next button, so they can add more accounts
  // final bool firstTimeUser = true;
  // hardcoded for now

  late void Function(Account)? onAccountChange;

  Account? newAccount;
  Account? account;

  List<Account> createdAccounts =[];

  @override
  void initState() {
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    // check whether user is editing/viewing an account or creating a new one
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    print(arguments);

    String? category = '';
   // Account? account; // TODO: fix, every time set state is called, a new object is made
    String accountName = 'Account';

    if(arguments != null ){
      String? operation = arguments['mode'] ?? null ;
      // Account? account = arguments['account'] ?? null;
      account = arguments['account'] ?? null;


      // print(operation);
      // print(account);

      if(operation == "add_account"){
        // print("user is adding an account!");
        account = context.read<AccountDatabase>().createEmptyAccount();
        createdAccounts.add(account!);

      }else if (operation == "edit_account" && account != null) {
        // print("user is editing ${account.name} !");

        accountName = account!.name;

        // edit the controllers
        accountController.text = accountName;
        usernameController.text = account!.username;
        passwordController.text = account!.password;

        // edit category
        category = account?.category;

      }else{
        print("error, ${operation}, ${account}");
      }
    }

    if(newAccount != null) {
      account = newAccount;
    } else if (account != null) {
      newAccount = account;
    }

    int numberOfStars(){
      // 1 star = filled in name, category, username, password
      // 1 star = at least one checkbox ticked
      // 1 star = some accounts/devices added

      int total = 0;
      if(account?.name!= "Account" && account?.category != "" &&
          account?.username != "" && account?.password != ""){
        ++total;
      }

      if(account!.incomingAccounts.toList().isNotEmpty){
        ++total;
      }

      for(String string in account!.incomingAccounts.toList()){
        if(string.substring(string.length-1) != ":"){
          ++total;
          break;
        }
      }

      return total;
    }

    int numStars = numberOfStars();



    void onDialogChanged(Account updatedAccount){
      newAccount = updatedAccount;

      // either page 1 or page 2 was updated, so need to recalculate number of stars
      setState(() {
        numStars = numberOfStars();
      });

    }

    void _showDialog(BuildContext context){
      showDialog(
          context: context,
          builder: (context){
            return MoreInformationDialog(account: newAccount!, onDialogChange: onDialogChanged,);
          }
      );
    }

    void categoryChanged(String newCategory){
      category = newCategory;
      account?.category = newCategory;
      setState(() {
        numStars = numberOfStars();
      });
    }

    void accountNameChanged(String newAccountName){
      accountName = newAccountName;
      account?.name = newAccountName;
      setState(() {
        numStars = numberOfStars();
      });
    }

    void onUsernameChanged(String username){
      account?.username = username;
      setState(() {
        numStars = numberOfStars();
      });
    }

    void onPasswordChanged(String password){
      account?.password = password;
      setState(() {
        numStars = numberOfStars();
      });
    }

    void enterMoreInfoButtonClicked(){
      context.read<AccountDatabase>().readAccounts();
      _showDialog(context);
    }

    void saveButtonClicked(){
      // get the fields
      // String accountCategory = category;
      // String accountUsername = usernameController.text;
      // String accountPassword = passwordController.text;

      if(account?.category == ""){
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
      }else if (account?.name == 'Account') {
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

          // account.name= accountName;
          // account.category = accountCategory;
          // account.username = accountUsername;
          // account.password = accountPassword;



          context.read<AccountDatabase>().updateAccount(account!);
        }else{ // account is null so create new account
          // context.read<AccountDatabase>().addAccount(accountName, accountCategory, accountUsername, accountPassword);
          // account?.name= accountName;
          // account?.category = accountCategory;
          // account?.username = accountUsername;
          // account?.password = accountPassword;

          context.read<AccountDatabase>().updateAccount(account!);
        }

        for(Account a in createdAccounts){
          if(a.name == "Account"){
            context.read<AccountDatabase>().deleteAccount(a!.id);
          }
        }

        // return to accounts page
        // Navigator.pushReplacementNamed(context, '/routing');
        Navigator.of(context).pushNamedAndRemoveUntil('/routing', (Route<dynamic> route) => false);
      }
    }

    void discardButtonClicked(){
      final dynamic arguments = ModalRoute.of(context)?.settings.arguments;
      String? operation = arguments['mode'] ?? null ;

      // if user clicked on add account, but then didnt save anything, then delete the account
      if(operation == "add_account"){
        context.read<AccountDatabase>().deleteAccount(account!.id);
        context.read<AccountDatabase>().deleteAccount(newAccount!.id);

        for(Account a in createdAccounts){
            context.read<AccountDatabase>().deleteAccount(a!.id);
        }

      }

     Navigator.of(context).pushNamedAndRemoveUntil('/routing', (Route<dynamic> route) => false);

    }

    // void nextButtonClicked(){
    //   print("next");
    //
    //   // TODO: clear all fields
    // }



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
                      onTextChanged: onUsernameChanged,
                    )
                ),

                // password
                WidgetWithCustomWidth(
                    width: 250,
                    widget: MyTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: passwordController,
                      onTextChanged: onPasswordChanged,
                    )
                ),

                // open dialog to enter more information
                WidgetWithCustomWidth(
                  widget: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: MyButton(
                      text: "Enter More Info",
                      fontSize: 16,
                      onButtonClicked: enterMoreInfoButtonClicked,
                      backgroundColour: greyButton,
                    ),
                  ),
                  width: 200,
                ),

                WidgetWithCustomWidth(
                    widget: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // save button
                          ButtonWithIcon(icon: Icons.add, text: "Save", onButtonClicked: saveButtonClicked,),

                          // discard button
                          ButtonWithIcon(icon: Icons.exit_to_app, text: "Discard", onButtonClicked: discardButtonClicked,),

                          // next button
                          // if (firstTimeUer) ButtonWithIcon(icon: Icons.arrow_forward, text: "Next", onButtonClicked: nextButtonClicked,),
                        ],
                      ),
                    ),
                ),
              ],
            ),

            // stars
            MyContainer(
              height: 75,
              isStarsContainer: true,
              children: [
                WidgetWithCustomWidth(
                    widget: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < numStars; i++) StarIcon(icon: Icons.star),
                        for (var i = 0; i < 3- numStars; i++) StarIcon(icon: Icons.star_outline),
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