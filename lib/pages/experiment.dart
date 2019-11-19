import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:toads_and_frogs/components/tile_map.dart';
import 'package:toads_and_frogs/query.dart';
import 'game_screen.dart';

class GamePage extends StatefulWidget {
  final int gameplay;
  GamePage({this.gameplay});
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Matrix4 matrix;
  @override
  void initState() {
    matrix = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MatrixGestureDetector(
        shouldRotate: false,
        shouldScale: true,
        shouldTranslate: false,
        onMatrixUpdate: (m, tm, sm, rm) {
          setState(() {
            matrix = m;
          });
        },
        child: Transform(
          transform: matrix,
          child: TileList(
            gamePlay: widget.gameplay,
          ),
        ),
      ),
    );
  }
}

class TextMap extends StatefulWidget {
  final int gameplay ;
  TextMap({this.gameplay = 1});
  
  @override
  _TextMapState createState() => _TextMapState();
}

class _TextMapState extends State<TextMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: <Widget>[
            SizedBox(
              height: Query.block * 2,
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
    );
  }
}
