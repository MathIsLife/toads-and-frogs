import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/levels.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/query.dart';

import 'game_screen.dart';

class LevelPage extends StatefulWidget {
  static final route = '/level_page';
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            
            Container(
              height: 90.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Select a level you wish to play!',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30.0
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: Query.width,
              height: Query.height - 95.0,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return LevelTile(level: LevelData.levels[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelTile extends StatelessWidget {
  final Level level;
  LevelTile({this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.amber),
        shape: BoxShape.circle,
        color: Colors.amberAccent,
      ),
      child: RaisedButton(
        padding: EdgeInsets.all(0.0),
        color: Colors.amberAccent,
        splashColor: Colors.amber,
        elevation: 16.0,
        shape: CircleBorder(),
        child: Text(
          '${level.level}',
          style: TextStyle(color: Colors.black87, fontSize: 30.0),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      builder: (context) => GameController(
                        gameDifficulty: level.difficulty,
                        frogs: level.frogs,
                        leafs: level.leafs,
                        toads: level.toads,
                        userFirst: level.userFirst,
                      ),
                    ),
                    ChangeNotifierProvider(
                      builder: (context) => Score(),
                    )
                  ],
                  child: GameScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
