import 'package:flutter/material.dart';
import 'package:toads_and_frogs/components/challenge_tiles.dart';

import '../constants.dart';

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(kiBg4))),
        child: Column(
          children: <Widget>[
              Row(children: <Widget>[
                MoveBox(),
                UndoBox(),
              ],
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: ,
              padding: const EdgeInsets.all(25.0),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ChallengeTile(
                    index: index,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}