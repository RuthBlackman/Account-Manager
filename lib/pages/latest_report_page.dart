import 'package:account_manger/components/buttons/my_button.dart';
import 'package:flutter/material.dart';

import '../colours.dart';

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
          Expanded(
            child: Padding(
              //    padding: const EdgeInsets.all(40.0),
              padding: const EdgeInsets.only(top: 40, left: 70, right: 70, bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Latest Report",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${numberOfProblems(generateProblemsMap())} problems",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),// todo: edit this when we have actual data
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ..._buildProblemWidgets(generateProblemsMap())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: MyButton(
              text: "Start Scan",
              backgroundColour: Colors.white,
              fontSize: 16,
              onButtonClicked: (){
                // TODO: open security report and start scan
                Navigator.pushNamed(context, '/security_report');
              },
            ),
          ),
        ],
      ),
    );
  }
}
