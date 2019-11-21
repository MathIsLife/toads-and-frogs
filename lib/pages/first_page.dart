import 'package:flutter/material.dart';
import 'package:toads_and_frogs/buttons/round_button.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/pages/game_modes.dart';
import 'package:toads_and_frogs/query.dart';
import 'level_page.dart';

class FirstPage extends StatefulWidget {
  static String route = '/';
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<FirstPage> {
  bool isLoadGame = false;
  @override
  Widget build(BuildContext context) {
    Query.loadAll(context);
    double block = Query.block;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(kiBg4), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Toads & Frogs',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: block * 9.0,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            RoundButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameMode()
                  ),
                );
              },
              tooltip: 'New Game',
              icon: Icon(
                Icons.play_arrow,
                color: Colors.black87,
              ),
              size: 15.0 * block,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RoundButton(
                  onPressed: (isLoadGame)
                      ? () {
                          print('loaded game');
                        }
                      : null,
                  tooltip: 'Load Saved Game',
                  icon: Icon(
                    Icons.navigate_next,
                    color: (isLoadGame) ? Colors.black : Colors.grey,
                  ),
                  size: block * 7.0,
                ),
                RoundButton(
                  onPressed: () {
                    print('multi');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LevelPage(
                          gameplay: 2,
                        ),
                      ),
                    );
                  },
                  tooltip: 'Multiplayer',
                  icon: Icon(
                    Icons.wc,
                    color: Colors.black,
                  ),
                  size: block * 7.0,
                ),
                RoundButton(
                  onPressed: () {
                    print("Settings");
                  },
                  tooltip: 'Settings',
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  size: block * 7.0,
                ),
                RoundButton(
                  onPressed: () {
                    print("Stats");
                  },
                  tooltip: 'Stats',
                  icon: Icon(
                    Icons.assessment,
                    color: Colors.black,
                  ),
                  size: block * 7.0,
                ),
                RoundButton(
                  onPressed: () {
                    print("Help me!");
                  },
                  tooltip: 'Instructions',
                  icon: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                  size: block * 7.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
