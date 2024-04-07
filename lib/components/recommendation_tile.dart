import 'package:flutter/material.dart';

import '../models/account.dart';

class RecommendationTile extends StatefulWidget {
  final int score;
  final List<Account> values;
  final Map<Account, List<String>> recommendationAccounts;


  const RecommendationTile({super.key, required this.score, required this.values, required this.recommendationAccounts});

  @override
  State<RecommendationTile> createState() => _RecommendationTileState();
}

class _RecommendationTileState extends State<RecommendationTile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool showRecommendations = false;

  void changeShowAccounts(){
    setState(() {
      showRecommendations = !showRecommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeShowAccounts(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Score: ${widget.score}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Column(
              //children: values.map((value) => Text(value.name)).toList(),
                children: showRecommendations ? <Widget>[
                  for(Account account in widget.values)
                    Column(
                      children: [
                        Text(account.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        const Text("Recommendations:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        if(widget.recommendationAccounts[account]!.isEmpty)
                          const Text("Nothing to recommend!"),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for(String recommendation in widget.recommendationAccounts[account]!)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("•"),
                                  const SizedBox(width: 10,),
                                  // Text(recommendation),
                                  Expanded(
                                    child: Text(
                                      recommendation,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2, // Limit to 2 lines
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  const Divider(),
                ]
                    :
                [ Column(
                  children: widget.values.map((value) => Text(value.name)).toList(),
                )]
            ),
          ],
        ),
      ),
    );
  }
}
