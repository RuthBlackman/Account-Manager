import 'package:flutter/material.dart';
import '../../models/account.dart';
import '../my_checkbox.dart';

class PageOne extends StatefulWidget {
  final Account account;
  final void Function(Account)? onPageChange;

  const PageOne({
    super.key,
    required this.account,
    required this.onPageChange,
  });

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  late Account account;
  late bool isTFAon ;
  late bool isEmailRegistered ;
  late bool usesPasswordManager ;
  late bool hasIncomingAccounts ;

  late void Function(Account)? onPageChange;


  @override
  void initState() {
    super.initState();
    account = widget.account;
    doStuff(account);

    onPageChange = widget.onPageChange;
  }


  void doStuff(Account a){
    List<String>? incomingAccounts = a?.incomingAccounts;

    isTFAon = false;
    usesPasswordManager = false;
    isEmailRegistered = false;
    hasIncomingAccounts = false;


    for(String string in incomingAccounts!){
      if(string.contains("2FA")){
        isTFAon = true;
      }

      if(string.contains("Password Manager")){
        usesPasswordManager = true;
      }

      if(string.contains("Recovery")){
        isEmailRegistered = true;
      }

      if(string.contains("SSO")){
        hasIncomingAccounts = true;
      }
    }

  }

  List<String> newIncomingAccounts (Account account, String operation, String typeOfAccess ){
    List<String> incomingAccounts = account.incomingAccounts.toList();
    if(operation == "Add"){

      incomingAccounts.add("${typeOfAccess}:");
    }else{

      incomingAccounts.removeWhere((element) => element.contains(typeOfAccess) == true);
    }

    return incomingAccounts;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Extra Information",
              style: TextStyle(fontSize: 30),
            ),
          ),
          MyCheckbox(
            checkboxText: 'Have you turned on Two-Factor Authentication for this '
                'account?',
            value: isTFAon,
            onChanged: (bool? value) {
              setState(() {
                isTFAon = value ?? false;
              });
              if(isTFAon){
                // context.read<AccountDatabase>().addAccessType(account.id, "2FA"); // add account id in page 2
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.add("2FA:");
                account.incomingAccounts = incomingAccounts;
              }

              if(!isTFAon){ // else if null, remove all 2FA strings from incoming accounts
                // context.read<AccountDatabase>().removeAccessType(account.id, "2FA");
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.removeWhere((element) => element.contains("2FA") == true);
                account.incomingAccounts = incomingAccounts;
              }

              onPageChange!(account);
            },
          ),
          MyCheckbox(
            checkboxText: 'Do you have an email address registered to this account?',
            value: isEmailRegistered,
            onChanged: (bool? value) {
              setState(() {
                isEmailRegistered = value ?? false;
              });
              if(isEmailRegistered){
                // context.read<AccountDatabase>().addAccessType(account.id, "Recovery"); // add account id in page 2
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.add("Recovery:");
                account.incomingAccounts = incomingAccounts;
              }

              if(!isEmailRegistered){ //
                // context.read<AccountDatabase>().removeAccessType(account.id, "Recovery");
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.removeWhere((element) => element.contains("Recovery") == true);
                account.incomingAccounts = incomingAccounts;
              }

              onPageChange!(account);
            },
          ),
          MyCheckbox(
            checkboxText: 'Do you use a password manager?',
            value: usesPasswordManager,
            onChanged: (bool? value) {
              setState(() {
                usesPasswordManager = value ?? false;
              });
              if(usesPasswordManager){
                // context.read<AccountDatabase>().addAccessType(account.id, "Password Manager"); // add account id in page 2
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.add("Password Manager:");
                account.incomingAccounts = incomingAccounts;
              }

              if(!usesPasswordManager){ // else if null, remove all 2FA strings from incoming accounts
                // context.read<AccountDatabase>().removeAccessType(account.id, "Password Manager");
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.removeWhere((element) => element.contains("Password Manager") == true);
                account.incomingAccounts = incomingAccounts;
              }

              onPageChange!(account);
            },
          ),
          MyCheckbox(
            checkboxText: 'Are there other accounts that provide access '
                  'to this account?',
            value: hasIncomingAccounts,
            onChanged: (bool? value) {
              setState(() {
                hasIncomingAccounts = value ?? false;
              });
              if(hasIncomingAccounts){
                // context.read<AccountDatabase>().addAccessType(account.id, "SSO"); // add account id in page 2
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.add("SSO:");
                account.incomingAccounts = incomingAccounts;
              }

              if(!hasIncomingAccounts){ // else if null, remove all 2FA strings from incoming accounts
                // context.read<AccountDatabase>().removeAccessType(account.id, "SSO");
                List<String> incomingAccounts = account.incomingAccounts.toList();
                incomingAccounts.removeWhere((element) => element.contains("SSO") == true);
                account.incomingAccounts = incomingAccounts;
              }

              onPageChange!(account);
            },
          ),
        ]
    );
  }
}

