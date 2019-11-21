import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/multi_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/pages/game_result.dart';

import '../query.dart';
import 'tiles.dart';

class MultiTile extends StatelessWidget {
  static int count = 0;
  final int index;
  final int gameplay;
  MultiTile({
    this.index,
    this.gameplay = 1,
  }) {
    print('$gameplay from tile');
  }

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

  Future<void> gotoResultMul(BuildContext context) async {
    var gc = Provider.of<MultiGameController>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () {
      int whoWon = gc.whoWon();
      if (whoWon != 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameResult(
              whoWon: whoWon + 2,
              list: gc.list,
            ),
          ),
        );
        // gc.dispose();
        // Provider.of<Score>(context).dispose();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    final Score scr = Provider.of<Score>(context);
    var gc = Provider.of<MultiGameController>(context);

    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: block * 9,
            width: block * 9,
            child: Image(
              image: AssetImage(kiLeaf2),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              gc.onDoubleTapped(index, scr);
              gotoResultMul(context);
            },
            child: Container(
              margin: EdgeInsets.all(0),
              height: block * 7,
              width: block * 7,
              child: getAvatar(gc.list[index]),
            ),
          )
        ],
      ),
    );
  }
}