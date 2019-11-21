import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/multi_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/components/tile_map.dart';
import 'package:toads_and_frogs/components/tiles.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/query.dart';
import 'package:transparent_image/transparent_image.dart';

class GameScreen extends StatefulWidget {
  static String route = '/gamemode/level_page/game_screen';
  final int gameplay;
  GameScreen({this.gameplay = 1}) {
    //print(gameplay);
  }
  @override
  _GameScreenState createState() => _GameScreenState();
}

int who = 1; //player

class _GameScreenState extends State<GameScreen> {
 
  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    return Scaffold(
      body: Container(
        width: Query.width,
        height: Query.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FadeInImage(
              image: AssetImage(kiBg2),
              placeholder: MemoryImage(kTransparentImage),
            ).image,
            fit: BoxFit.fitHeight,
            alignment: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: block * 2,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ScoreWidget(),
              ),
            ),
            Turn(
              gameplay: widget.gameplay,
            ),
            Expanded(
              child: Center(child: TileMap(gameplay: widget.gameplay)),
            ),
            Expanded(
              flex: 3,
              child: TileList(
                gamePlay: widget.gameplay,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Turn extends StatelessWidget {
  final int gameplay;
  Turn({this.gameplay = 1});

  String whosTurn(context) {
    if (gameplay == 1) {
      return Provider.of<GameController>(context).turn();
    }
    return Provider.of<MultiGameController>(context).turn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${whosTurn(context)}',
        style: TextStyle(
          fontSize: Query.block * 4,
          color: Colors.yellow,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
              color: Colors.blue,
            ),
            Shadow(
              blurRadius: 8.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    final Score scr = Provider.of<Score>(context);
    return Text(
      'Hops: Frog: ${scr.frogHop}, Toad: ${scr.toadHop}',
      style: TextStyle(
        fontSize: block * 5,
        color: Colors.white,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
            color: Colors.grey,
          ),
          Shadow(
            blurRadius: 8.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class TileList extends StatefulWidget {
  final int gamePlay;

  TileList({Key key, this.gamePlay}) : super(key: key);
  @override
  _TileListState createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  @override
  Widget build(BuildContext context) {
    print(widget.gamePlay);
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: (widget.gamePlay == 1)
            ? Provider.of<GameController>(context, listen: false)
                .getAvatarListLength()
            : Provider.of<MultiGameController>(context, listen: false)
                .getAvatarListLength(),
        padding: const EdgeInsets.all(25.0),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Tile(
              gameplay: widget.gamePlay,
              index: index,
            ),
          );
        },
      ),
    );
  }
}
