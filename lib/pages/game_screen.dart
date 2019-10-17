import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/pages/game_result.dart';
import 'package:toads_and_frogs/query.dart';

class GameScreen extends StatefulWidget {
  static String route = '/game_screen';
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    Query q = Query(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: q.block * 2,),
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
    );
  }
}

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query q = Query(context);
    final Score scr = Provider.of<Score>(context);
    return Text(
      'Hops: Frog: ${scr.frogHop}, Toad: ${scr.toadHop}',
      style: TextStyle(fontSize: q.block * 5,color: Colors.orange),
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
        itemCount: Provider.of<GameController>(context, listen: false)
            .getAvatarListLength(),
        padding: const EdgeInsets.all(25.0),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
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
    //print('${++count}');
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
    Query q =  Query(context);
    final Score scr = Provider.of<Score>(context);
    final GameController gc = Provider.of<GameController>(context);
    
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: q.block * 9,
            width: q.block * 9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: q.block * 0.7),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image(
              image: AssetImage(kiLeaf),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              gc.onDoubleTapped(index, scr);
              if (gc.gameState != GameController.CONTINUE_GAME) {
                Navigator.pushNamed(context, GameResult.route);
              }
            },
            child: Container(
              margin: EdgeInsets.all(0),
              height: q.block * 7,
              width: q.block * 7,
              child: getAvatar(gc.list[index]),
            ),
          )
        ],
      ),
    );
  }
}
