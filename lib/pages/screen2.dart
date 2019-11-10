import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/components/tiles.dart';


class Screen extends StatefulWidget {
  final String route = '/screen2';
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[GameGrid()],
      ),
    );
  }
}

class GameGrid extends StatefulWidget {
  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  
  List<Widget> getThem(int n, int k) {
    List<Widget> ret = List<Widget>();
    bool rev = false;
    for (int i = 0, c = 0; i < n; i++) {
      if (i % k == 0 && i > 0) {
        if (rev) {
          rev = false;
          c = c + k + 1;
        } else {
          rev = true;
          c = c + k - 1;
          if (c >= n) c = n - 1;
        }
      }
      ret.add(Tile(index: c));
      if (rev)
        c--;
      else
        c++;
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context, listen: false);
    return GridView.count(
      crossAxisCount: 5,
      children: getThem(gc.getAvatarListLength(), 5),
    );
  }
}
