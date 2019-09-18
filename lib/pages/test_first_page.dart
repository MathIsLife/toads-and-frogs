import 'package:flutter/material.dart';
import 'package:toads_and_frogs/buttons/round_button.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  bool isLoadGame = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Toads & Frogs',
                style: TextStyle(color: Colors.amber, fontSize: 60.0),
              ),
            ),
            RoundButton(
              onPressed: () {
                print('pressed');
              },
              text: Text(
                'New Game',
                style: TextStyle(color: Colors.black87, fontSize: 20.0),
              ),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.black87,
              ),
              size: 100.0,
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
                  text: Text(
                    'Load Game',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                  icon: Icon(Icons.navigate_next,
                      color: (isLoadGame) ? Colors.black : Colors.grey),
                ),
                RoundButton(
                  onPressed: () {
                    print("Multiplayer");
                  },
                  text: Text(
                    'Multiplayer',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                  icon: Icon(
                    Icons.wc,
                    color: Colors.black,
                  ),
                ),
                RoundButton(
                  onPressed: () {
                    print("Settings");
                  },
                  text: Text(
                    'Settings',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
                RoundButton(
                  onPressed: () {
                    print("Stats");
                  },
                  text: Text(
                    'Stats',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                  icon: Icon(
                    Icons.assessment,
                    color: Colors.black,
                  ),
                ),
                RoundButton(
                  onPressed: () {
                    print("Help me!");
                  },
                  text: Text(
                    'Help',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                  icon: Icon(
                    Icons.help_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
