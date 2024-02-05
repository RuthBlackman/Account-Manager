// todo: score for an account is dependent on the user's answers

import 'package:account_manger/components/buttons/my_button.dart';
import 'package:account_manger/components/more_information_dialog/page_two.dart';
import 'package:account_manger/models/account.dart';
import 'package:flutter/material.dart';
import '../colours.dart';
import 'more_information_dialog/page_one.dart';


class MoreInformationDialog extends StatefulWidget {
  final Account account;
  final void Function(Account)? onDialogChange;

  const MoreInformationDialog({Key? key, required this.account, required this.onDialogChange});

  @override
  _MoreInformationDialogState createState() => _MoreInformationDialogState();
}

class _MoreInformationDialogState extends State<MoreInformationDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late Account account;

  late void Function(Account)? onDialogChanged;

  @override
  void initState() {
    super.initState();
    account = widget.account;
    onDialogChanged = widget.onDialogChange;
  }

  void onPageChange(account){
    onDialogChanged!(account);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),

        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 20),
            child: Container(
              // height: 550,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // PageView to show multiple pages
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        PageOne(account: account, onPageChange: onPageChange),
                       PageTwo(account:  account),

                      ],
                    ),
                  ),

                  // Indicator to show the current page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2, // Number of pages
                          (index) => Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  MyButton(
                      text: "Close",
                      fontSize: 16,
                      backgroundColour: greyButton,
                      onButtonClicked: (){
                        // close dialog
                        Navigator.pop(context);
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
