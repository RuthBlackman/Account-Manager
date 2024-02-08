import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';
import '../../models/account_database.dart';

class AccountDropdown extends StatefulWidget {
  final Account currentAccount;
  final void Function(Account) onAccountChanged;
  final String typeOfAccess;
  const AccountDropdown({super.key, required this.currentAccount, required this.onAccountChanged, required this.typeOfAccess});

  @override
  _AccountDropdownState createState() => _AccountDropdownState();
}

class _AccountDropdownState extends State<AccountDropdown> {
  late Account currentAccount;
  late String typeOfAccess;

  List<dynamic> selectedAccounts = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  late List<Account> accounts;

  @override
  void initState() {
    super.initState();
    currentAccount = widget.currentAccount;
    typeOfAccess = widget.typeOfAccess;
  }

  void checkIfOptionsSelected(Account account, String type){
    // selectedOptions = list of accounts, where the id of the account is in incomingAccounts for this type
    // ie, if incomingAccounts = ["2FA:1"], then the account with the id 1 will be in selectedOptions
    
    List<int> selectedIds = [];
    for(String string in account.incomingAccounts.toList()){
      if(string.contains(type)){ // either "2FA:1" or "2FA:"
        if(string.substring(string.length-1) != ":"){ // so if it's "2FA:1"
          // need to get the substring from : to the end
          selectedIds.add(int.parse(string.substring(string.indexOf(":")+1, string.length)));
        }
      }
    }

    // now, for each account with an id in selectedIds, add account to selectedOptions
    final accountDatabase = context.watch<AccountDatabase>();
    accounts = accountDatabase.currentAccounts;

    selectedAccounts = [];

    for(Account account in accounts){
      if(selectedIds.contains(account.id)){
        selectedAccounts.add(account);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
      final accountDatabase = context.watch<AccountDatabase>();
      accounts = accountDatabase.currentAccounts;

      final _items = accounts
          .map((account) => MultiSelectItem<Account?>(account, account.name))
          .toList();

      checkIfOptionsSelected(currentAccount, typeOfAccess);


    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          MultiSelectDialogField(
            key: _multiSelectKey,
            items: _items,
            initialValue: selectedAccounts,
            title: const Text("Accounts/Devices"),
            selectedColor: Colors.blue,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            ),
            buttonIcon: const Icon(
              Icons.account_circle_sharp,
              color: Colors.blue,
            ),
            buttonText: Text(
              "Select account/device",
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            onConfirm: (results) {
              selectedAccounts = results;


              // remove String with just typeOfAccess:
              List<String> incomingAccounts = currentAccount.incomingAccounts.toList();
              incomingAccounts.removeWhere((element) => element.contains(typeOfAccess) == true);
              currentAccount.incomingAccounts = incomingAccounts;

              // add String with type and account id :
              for(Account account in selectedAccounts){
                List<String> incomingAccounts = currentAccount.incomingAccounts.toList();
                incomingAccounts.add("${typeOfAccess}:${account.id}");
                currentAccount.incomingAccounts = incomingAccounts;
              }

              widget.onAccountChanged(currentAccount);

            },
          ),
        ],
      ),
    );
  }


}
