import 'package:flutter/material.dart';

import '../../models/account.dart';

class PageTwo extends StatefulWidget {
  final Account account;
  const PageTwo({super.key, required this.account});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  late Account account;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    account = widget.account;
    print("initialise state for page 2: ${account.incomingAccounts}");
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(account.name),
      ),
    );
  }
}
