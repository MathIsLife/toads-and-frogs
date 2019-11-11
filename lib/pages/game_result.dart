import 'package:flutter/material.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/query.dart';

import 'level_page.dart';

class GameResult extends StatefulWidget {
  static final route = '/game_result';

  final int whoWon;
  final List<TileAvatar> list;
  GameResult({this.whoWon, this.list});

  @override
  _GameResultState createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {
  String aiWon = "Android Wins!";
  String uWon = "You Win!";
  String winner;
  Color resColor;

  String getWinner() {
    if (widget.whoWon == 1) {
      resColor = Colors.green;
      return uWon;
    } else if (widget.whoWon == 2) {
      resColor = Colors.red;
      return aiWon;
    }
    return 'ehhe';
  }

  @override
  Widget build(BuildContext context) {
    winner = getWinner();
    
    double block = Query.block;
    double hr = Query.heightRatio;
    double wr = Query.widthRatio;

    return Scaffold(
      body: Scaffold(
        body: Center(
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
                child: Text(
                  winner,
                  style: TextStyle(
                    color: resColor,
                    fontSize: block * 8,
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
                color: Colors.amber,
                child: Container(
                  width: 200 * wr,
                  height: 50 * hr,
                  child: Center(
                    child: Text(
                      'New Game',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LevelPage()),
                  );
                },
              )
            ],
          ),
        ),
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
          border: Border.all(width: 3.0, color: Colors.black54),
        ),
        width: 50.0 * Query.widthRatio,
        height: 50.0 * Query.heightRatio,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: getAvatar(av),
        ));
  }
}
