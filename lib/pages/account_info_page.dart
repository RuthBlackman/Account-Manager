import 'package:account_manger/colours.dart';
import 'package:account_manger/components/account_name.dart';
import 'package:account_manger/components/category_dropdown.dart';
import 'package:account_manger/components/more_information_dialog.dart';
import 'package:account_manger/components/my_appbar.dart';
import 'package:account_manger/components/my_button.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:account_manger/components/my_textfield.dart';
import 'package:account_manger/components/star_icon.dart';
import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  AccountInfoPage({super.key});

  // text editing controllers
  final TextEditingController accountController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    return Scaffold(
      appBar: const MyAppBar(title: "Account Information"),
      backgroundColor: blueBackground,
      body: Column(
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
              WidgetWithCustomWidth(widget: AccountNameWidget()),

              WidgetWithCustomWidth(
                widget: CategoryDropdown(),
                width: 250,
              ),

              WidgetWithCustomWidth(
                  width: 250,
                  widget: MyTextField(
                    hintText: "Username",
                    obscureText: false,
                    controller: usernameController,
                  )
              ),

              WidgetWithCustomWidth(
                  width: 250,
                  widget: MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController,
                  )
              ),

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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                        child: MyButton(
                          text: "Save",
                          width: 90,
                          height: 90,
                          color: greyButton,
                          icon: Icons.add,
                          onTap: (){},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyButton(
                          text: "Exit",
                          width: 90,
                          height: 90,
                          color: greyButton,
                          icon: Icons.exit_to_app,
                          onTap: (){},
                        ),
                      ),
                      if(firstTimeUer)  Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                        child: MyButton(
                          text: "Next",
                          width: 90,
                          height: 90,
                          color: greyButton,
                          icon: Icons.arrow_forward_outlined,
                          onTap: (){},
                        ),
                      ),
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
    );
  }
}

