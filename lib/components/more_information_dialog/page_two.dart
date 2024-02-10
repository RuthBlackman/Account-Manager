import 'package:account_manger/components/more_information_dialog/enter_more_info_panel.dart';
import 'package:flutter/material.dart';

import '../../models/account.dart';

class PageTwo extends StatefulWidget {
  final Account account;
  final void Function(Account)? onPageChange;
  const PageTwo({super.key, required this.account, required this.onPageChange});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  late Account account;
  late bool isTFAon;
  late bool isEmailRegistered;
  late bool usesPasswordManager;
  late bool hasIncomingAccounts;


  @override
  void initState() {
    super.initState();
    account = widget.account;
    print("initialise state for page 2: ${account.incomingAccounts}");

    // check whether checkboxes were ticked
    checkIncomingAccounts(account);
  }

  void checkIncomingAccounts(Account account){
    account.incomingAccounts.where((element) => element.contains("2FA")).isNotEmpty ? isTFAon = true : isTFAon = false;
    account.incomingAccounts.where((element) => element.contains("Recovery")).isNotEmpty ? isEmailRegistered = true : isEmailRegistered = false;
    account.incomingAccounts.where((element) => element.contains("Password Manager")).isNotEmpty ? usesPasswordManager = true : usesPasswordManager = false;
    account.incomingAccounts.where((element) => element.contains("SSO")).isNotEmpty ? hasIncomingAccounts = true : hasIncomingAccounts = false;
  }

  void onPanelChanged(Account account){
    widget.onPageChange!(account);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Extra Information",
              style: TextStyle(fontSize: 30),
            ),
          ),



          switch (isTFAon){
            true => EnterMoreInfoPanel(account: account, typeOfAccess: "2FA", onPanelChanged: onPanelChanged),
            false => SizedBox.shrink(), // empty widget, takes up smallest area possible
          },

          switch (isEmailRegistered){
            true => EnterMoreInfoPanel(account: account, typeOfAccess: "Recovery", onPanelChanged: onPanelChanged),
            false => SizedBox.shrink(),
          },

          switch (usesPasswordManager){
            true => EnterMoreInfoPanel(account: account, typeOfAccess: "Password Manager", onPanelChanged: onPanelChanged),
            false => SizedBox.shrink(),
          },

          switch (hasIncomingAccounts){
            true => EnterMoreInfoPanel(account: account, typeOfAccess: "SSO", onPanelChanged: onPanelChanged),
            false => SizedBox.shrink(),
          },


        ],
      ),
    );
  }
}
