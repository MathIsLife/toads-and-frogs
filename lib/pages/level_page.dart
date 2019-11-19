import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/levels.dart';
import 'package:toads_and_frogs/backend/multi_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/query.dart';

import '../constants.dart';
import 'game_screen.dart';

class LevelPage extends StatefulWidget {
  final int gameplay;
  LevelPage({this.gameplay}) {
    //print('$gameplay yo wtf');
  }
  static final route = '/level_page';
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    double hr = Query.heightRatio, wr = Query.widthRatio;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kiBg2),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Column(
              children: <Widget>[
                // Container(
                //   height: 60.0 * hr,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Center(
                //       child: Text(
                //         'Select a level you wish to play!',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: Query.block * 4,
                //           fontWeight: FontWeight.w600,
                //           letterSpacing: 2,

                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Center(
                  child: Container(
                    width: Query.width - 100.0,
                    height: Query.height, //- 95.0 * hr
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return LevelTile(level: LevelData.levels[index], gamePlay: widget.gameplay,);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LevelTile extends StatelessWidget {
  final Level level;
  final gamePlay;
  LevelTile({this.level, this.gamePlay = 1});

  void gotoGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                builder: (context) => GameController(
                  gameDifficulty: level.difficulty,
                  frogs: level.frogs,
                  leafs: level.leafs,
                  toads: level.toads,
                  userFirst: level.userFirst,
                ),
              ),
              ChangeNotifierProvider(
                builder: (context) => Score(),
              )
            ],
            child: GameScreen(gameplay: 1,),
          );
        },
      ),
    );
  }

  void gotoGameMul(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                builder: (context) => MultiGameController(
                  frogFirst: level.userFirst,
                  frogs: level.frogs,
                  leafs: level.leafs,
                  toads: level.toads,
                ),
              ),
              ChangeNotifierProvider(
                builder: (context) => Score(),
              )
            ],
            child: GameScreen(gameplay: gamePlay,),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30 * Query.widthRatio,
      height: 30 * Query.heightRatio,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.amber),
        shape: BoxShape.circle,
        color: Colors.amberAccent,
      ),
      child: RaisedButton(
        padding: EdgeInsets.all(0.0),
        color: Colors.amberAccent,
        splashColor: Colors.amber,
        elevation: 16.0,
        shape: CircleBorder(),
        child: Text(
          '${level.level}',
          style: TextStyle(color: Colors.black, fontSize: 4 * Query.block),
        ),
        onPressed: () {
          print('$gamePlay from leveltile');
          if (gamePlay == 1) {
            gotoGame(context);
          } else {
            gotoGameMul(context);
          }
        },
      ),
    );
  }
}
