import 'package:account_manger/components/more_information_dialog/account_dropdown.dart';
import 'package:account_manger/components/my_checkbox.dart';
import 'package:flutter/material.dart';

import '../../models/account.dart';

class EnterMoreInfoPanel extends StatefulWidget {
  final Account account;
  final String typeOfAccess;
  final void Function(Account)? onPanelChanged;
  
  const EnterMoreInfoPanel({super.key, required this.account, required this.typeOfAccess, required this.onPanelChanged});

  @override
  State<EnterMoreInfoPanel> createState() => _EnterMoreInfoPanelState();
}

class _EnterMoreInfoPanelState extends State<EnterMoreInfoPanel> {
  bool accountAdded = false;
  late Account account;
  late String type;

  @override
  void initState() {
    super.initState();
    account = widget.account;
    type = widget.typeOfAccess;

    // if incomingaccounts contains a string like typeOfAccess:id, then accountAdded should be true
    checkIfAccountAdded(account,type);
  }

  void checkIfAccountAdded(Account account, String type){
    List<String> incomingAccounts = account.incomingAccounts.toList();
    incomingAccounts.where((element) => (element.substring(element.length-1) != ":")).isNotEmpty ? accountAdded = true : accountAdded = false;
  }

  void onCheckboxChanged(bool? value){
    setState(() {
      accountAdded = value!;
    });
  }

  void onAccountChanged(Account s){
    widget.onPanelChanged!(s);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(type),

        MyCheckbox(checkboxText: "Have you created an account or a device that uses this access type?", value: accountAdded, onChanged: onCheckboxChanged),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: switch(accountAdded){
            // if true, then display a dropdown menu of all the accounts and allow the user to click on them, which adds them to incoming accounts
            true => AccountDropdown(currentAccount:account, onAccountChanged: onAccountChanged, typeOfAccess: type,),

            // if false, then ask the user to create the device/account first and then come back
            false => Text("Please create account/device first and then come back."),
          },
        )
      ],
    );
  }
}
