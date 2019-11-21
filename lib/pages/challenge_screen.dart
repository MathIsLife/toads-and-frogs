import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/challenge_controller.dart';
import 'package:toads_and_frogs/components/challenge_tiles.dart';
import 'package:toads_and_frogs/pages/challenge_result.dart';
import '../constants.dart';
import '../query.dart';

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  void gotoResult(BuildContext context, String result, List<String> list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChallegeResult(
          gameresult: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GameControl gc = Provider.of<GameControl>(context, listen: false);

    Query.loadAll(context);
    double block = Query.block;
    return Stack(
      children: <Widget>[
        Consumer<GameControl>(
          builder: (_, gcl, __) {
            print('dhur');
            Future.delayed(Duration(microseconds: 20), () {
              if (gcl.state == 'end') {
                gcl.state = GameControl.continueGame;
                gotoResult(context, gcl.result, gcl.list);
              }
            });
            return Container();
          },
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(kiBg4), fit: BoxFit.fill),
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
            color: Colors.white.withOpacity(0.01),
          ),
        ),
        Positioned(
          bottom: block * 5, // 36.SOMETING
          child: Container(
            width: Query.width,
            height: Query.height - block * 5,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: gc.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ChallengeTile(
                    index: index,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MoveBox extends StatelessWidget {
  const MoveBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
    );
  }
}

class UndoBox extends StatelessWidget {
  const UndoBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
    );
  }
}
