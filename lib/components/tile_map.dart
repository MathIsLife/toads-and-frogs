import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/challenge_controller.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/multi_controller.dart';

class TileMap extends StatelessWidget {
  final int gameplay;
  TileMap({this.gameplay});
  Color getColor(TileAvatar avatar) {
    switch (avatar) {
      case TileAvatar.empty:
        return Colors.white54;
        break;
      case TileAvatar.frog:
        return Colors.green;
        break;
      case TileAvatar.toad:
        return Colors.brown;
        break;
      default:
        return Colors.white;
    }
  }
  Color getColorChallenge(String av) {
    switch (av) {
      case 'empty':
        return Colors.white54;
        break;
      case 'frog':
        return Colors.green;
        break;
      case 'toad':
        return Colors.brown;
        break;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (gameplay == 1) {
      GameController gc = Provider.of<GameController>(context);
      List<TileAvatar> list = gc.list;
      return Center(
        child: Container(
          width: 37.0 * list.length + 13.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            padding: EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(gc.list[index]),
                  border: Border.all(color: Colors.white60, width: 3.0),
                ),
                width: 33.0,
                height: 33.0,
              );
            },
          ),
        ),
      );
    }
    else if (gameplay == 2) {
      MultiGameController gc = Provider.of<MultiGameController>(context);
      List<TileAvatar> list = gc.list;
      return Center(
        child: Container(
          width: 37.0 * list.length + 13.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            padding: EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(gc.list[index]),
                  border: Border.all(color: Colors.white60, width: 3.0),
                ),
                width: 33.0,
                height: 33.0,
              );
            },
          ),
        ),
      );
    } else {
      GameControl gc = Provider.of<GameControl>(context);
      List<String> list = gc.list;
      return Center(
        child: Container(
          width: 37.0 * list.length + 13.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            padding: EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorChallenge(gc.list[index]),
                  border: Border.all(color: Colors.white60, width: 3.0),
                ),
                width: 33.0,
                height: 33.0,
              );
            },
          ),
        ),
      );
    }
  }
}
