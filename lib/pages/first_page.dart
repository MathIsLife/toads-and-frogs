import 'package:flutter/material.dart';
import 'package:toads_and_frogs/buttons/round_button.dart';
import 'package:toads_and_frogs/query.dart';

class FirstPage extends StatefulWidget {
  static String route = '/';
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<FirstPage> {
  bool isLoadGame = false;
  Query query;
  @override
  Widget build(BuildContext context) {
    query = Query(context);
    double block = query.block;

    return Scaffold(
      body: Container(
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
                ),
              ),
            ),
            RoundButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game_screen');
              },
              tooltip: 'New Game',
              icon: Icon(
                Icons.play_arrow,
                color: Colors.black87,
              ),
              size: 15 * block,
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
                  size: block * 7,
                ),
                RoundButton(
                  onPressed: () {
                    print("Multiplayer");
                  },
                  tooltip: 'Multiplayer',
                  icon: Icon(
                    Icons.wc,
                    color: Colors.black,
                  ),
                  size: block * 7,
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
                  size: block * 7,
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
                  size: block * 7,
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
                  size: block * 7,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
