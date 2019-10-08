import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/backend/enums.dart';

class GameScreen extends StatefulWidget {
  static String route = '/game_screen';
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
        return Material(
          child: Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: ScoreWidget(),
                    ),
                  ),
                  Expanded(
                    child: TileList(),
                  )
                ],
              ),
            ),
          ),
        );
      }
    
}

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Score scr = Provider.of<Score>(context);
    return Text(
      'Hops: frog: ${scr.frogHop}, toad: ${scr.toadHop}',
      style: TextStyle(fontSize: 50.0, fontFamily: 'Fira Code'),
    );
  }
}

class TileList extends StatefulWidget {
  TileList({Key key}) : super(key: key);
  @override
  _TileListState createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        padding: EdgeInsets.all(25.0),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Tile(
              index: index,
            ),
          );
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  static int count = 0;
  final int index;
  Tile({
    this.index,
  }) {
    print('${++count}');
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

  @override
  Widget build(BuildContext context) {
    final Score scr = Provider.of<Score>(context);
    final GameController gc = Provider.of<GameController>(context);
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 4.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image(
              image: AssetImage(kiLeaf),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              int cur = index, prev = index - 1, next = index + 1;
              if (gc.list[cur] == TileAvatar.frog && next < gc.list.length) {
                if (gc.list[next] == TileAvatar.empty) {
                  gc.setAvatarAt(cur, TileAvatar.empty);
                  gc.setAvatarAt(next, TileAvatar.frog);
                } else if (gc.list[next] == TileAvatar.toad &&
                    next + 1 < gc.list.length) {
                  if (gc.list[next + 1] == TileAvatar.empty) {
                    scr.incrementHop(TileAvatar.frog);
                    gc.setAvatarAt(cur, TileAvatar.empty);
                    gc.setAvatarAt(next + 1, TileAvatar.frog);
                  }
                }
              } else if (gc.list[cur] == TileAvatar.toad && prev >= 0) {
                if (gc.list[prev] == TileAvatar.empty) {
                  gc.setAvatarAt(cur, TileAvatar.empty);
                  gc.setAvatarAt(prev, TileAvatar.toad);
                } else if (gc.list[prev] == TileAvatar.frog &&
                    prev - 1 >= 0 &&
                    gc.list[prev - 1] == TileAvatar.empty) {
                  scr.incrementHop(TileAvatar.toad);
                  gc.setAvatarAt(cur, TileAvatar.empty);
                  gc.setAvatarAt(prev - 1, TileAvatar.toad);
                }
              }
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 100.0,
              width: 100.0,
              child: getAvatar(gc.list[index]),
            ),
          )
        ],
      ),
    );
  }
}
