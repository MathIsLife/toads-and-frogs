import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/game_modes.dart';
import 'package:toads_and_frogs/query.dart';

import 'level_page.dart';

class GameResult extends StatefulWidget {
  static final route = '/game_result';

  final int whoWon, gametype; // 1 -> single 2 -> multi
  final List<TileAvatar> list;
  GameResult({this.whoWon, this.list, this.gametype = 1});

  @override
  _GameResultState createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {
  String aiWon = "Android Wins!";
  String uWon = "You Win!";
  String frogWon = 'Frog Wins!';
  String toadWon = 'Toad Wins!';
  String winner;
  Color resColor;

  String getWinner() {
    if (widget.whoWon == 1) {
      resColor = Colors.green;
      return uWon;
    } else if (widget.whoWon == 2) {
      resColor = Colors.red;
      return aiWon;
    } else if (widget.whoWon == 3) {
      resColor = Colors.lime;
      return frogWon;
    } else {
      resColor = Colors.brown;
      return toadWon;
    }
  }

  @override
  void initState() {
    winner = getWinner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    double hr = Query.heightRatio;
    double wr = Query.widthRatio;

    return Scaffold(
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
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50.0 * hr,
                  width: 50.0 * widget.list.length * wr,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.list.length,
                    itemBuilder: (context, i) {
                      return ResTile(
                        av: widget.list[i],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40.0 * hr,
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 20,
                    margin: EdgeInsets.all(8.0),
                    color: resColor,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        winner,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: block * 5,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0 * hr,
                ),
                RaisedButton(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.orange,
                  child: Container(
                    width: 200 * wr,
                    height: 50 * hr,
                    child: Center(
                      child: Text(
                        'New Game',
                        style: TextStyle(
                          fontSize: Query.block * 3.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => LevelPage(gameplay: widget.gametype,)),
                    // );
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResTile extends StatelessWidget {
  final TileAvatar av;
  ResTile({this.av});

  Widget getAvatar(TileAvatar avatar) {
    switch (avatar) {
      case TileAvatar.empty:
        return Container();
        break;
      case TileAvatar.frog:
        return Image(
          image: AssetImage(kiFrog),
        );
        break;
      case TileAvatar.toad:
        return Image(
          image: AssetImage(kiToad),
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3.0, color: Colors.white54),
          color: Colors.white54),
      width: 50.0 * Query.widthRatio,
      height: 50.0 * Query.heightRatio,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: getAvatar(av),
      ),
    );
  }
}
