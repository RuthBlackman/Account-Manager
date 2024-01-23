import 'package:account_manger/colours.dart';
import 'package:account_manger/components/my_button.dart';
import 'package:account_manger/components/my_container.dart';
import 'package:flutter/material.dart';

enum Problems {
  passwordReused,
  MFANotActivated,
}

class LatestReport extends StatefulWidget {
  const LatestReport({super.key});

  @override
  State<LatestReport> createState() => _LatestReportState();
}

class _LatestReportState extends State<LatestReport> {
  // todo need to latest report (ie number of distinct problems, and number of accounts affected by those problems)

  // to demonstrate how page will look
  Map<Problems, int> generateProblemsMap() {
    return {
      Problems.passwordReused: 1,
      Problems.MFANotActivated: 2,
    };
  }

  int numberOfProblems(Map<Problems, int> problemsMap) {
    return problemsMap.length;
  }

  // Function to build Text widgets for each problem
  List<Widget> _buildProblemWidgets(Map<Problems, int> problemsMap) {
    List<Widget> widgets = [];

    problemsMap.forEach((problem, number) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${problem.toString().split('.').last}: $number',
          style: TextStyle(fontSize: 16),
        ),
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blueBackground,
      width: MediaQuery.of(context).size.width,
      child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 20.0),
            //   child: Text(
            //     "Welcome",
            //     style: TextStyle(
            //         fontSize: 20,
            //         color: purpleBackground),
            //   ),
            // ),

            Container(
              width: 300,
              child: MyContainer(
                  children: [
                    WidgetWithCustomWidth(
                        widget: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Latest Report",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                    ),
                    WidgetWithCustomWidth(
                      widget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${numberOfProblems(generateProblemsMap())} problems",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),// todo: edit this when we have actual data
                        ),
                      ),
                    ),
                    WidgetWithCustomWidth(widget: Column(
                      children: [
                        ..._buildProblemWidgets(generateProblemsMap())
                      ],
                    ))
                  ],
                  height: 300,
                  isStarsContainer: false
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                  text: "Start Scan",
                  width: 200,
                  height: 70,
                  color: white,
                  onTap: (){
                    // todo: open security report and start scan
                    Navigator.pushNamed(context, '/security_report');
                  }
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: MyButton(
            //       text: "Add Account",
            //       width: 200,
            //       height: 70,
            //       color: white,
            //       onTap: (){
            //         // go to account info page, and clear values
            //         Navigator.pushReplacementNamed(context, "/account_info_page");
            //       }
            //   ),
            // ),
          ],
      ),
    );
  }
}
