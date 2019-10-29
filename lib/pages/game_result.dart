import 'package:flutter/material.dart';
import 'package:toads_and_frogs/pages/game_screen.dart';
import 'package:toads_and_frogs/pages/init_config.dart';
import 'package:toads_and_frogs/query.dart';


class GameResult extends StatefulWidget {
  static final route = '/game_result';

  @override
  _GameResultState createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {
  String aiWon = "Android Wins!";
  String uWon = "You Win!";
  String winner = '';
  Color resColor = Colors.white;

  String getWinner() {
    if (who == 1) {
      resColor = Colors.green;
      return uWon;
    } else if (who == 2) {
      resColor = Colors.red;
      return aiWon;
    }
    return 'ehhe';
  }

  @override
  Widget build(BuildContext context) {
    winner = getWinner();
    Query q = Query(context);
    double block = q.block;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              height: 20.0,
            ),
            FlatButton(
              color: Colors.amber,
              child: Text(
                'New Game',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InitConfig()));
              },
            )
          ],
        ),
      ),
    );
  }
}
