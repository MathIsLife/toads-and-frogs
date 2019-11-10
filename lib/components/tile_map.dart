import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';

class TileMap extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    List<TileAvatar> list = gc.list;
    return Center(
      child: Container(
        width: 50 * list.length + 23.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          padding: EdgeInsets.all(13.0),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(gc.list[index]),
                border: Border.all(color: Colors.white60, width: 3.0),
              ),
              width: 45,
              height: 45,
            );
          },
        ),
      ),
    );
  }
}
