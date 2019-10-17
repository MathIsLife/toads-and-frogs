import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
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

  String getWinner(int x) {
    if (x == 1) {
      resColor = Colors.green;
      return uWon;
    }
    else if (x == 2) {
      resColor = Colors.red;
      return aiWon;
    }
    return 'ehhe';
  }

  @override
  Widget build(BuildContext context) {
    int whoWon = Provider.of<GameController>(context, listen: false).gameState;
    winner = getWinner(whoWon);
    Query q = Query(context);
    double block = q.block;

    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            winner,
            style: TextStyle(
              color: resColor,
              fontSize: block * 8,
            ),
          ),
        ),
      ),
    );
  }
}
