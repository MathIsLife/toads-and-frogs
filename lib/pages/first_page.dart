import 'package:flutter/material.dart';
import 'package:toads_and_frogs/buttons/round_button.dart';
import 'package:toads_and_frogs/media_query.dart';

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
                style:
                    TextStyle(color: Colors.amber, fontSize: block * 9.0),
              ),
            ),
            RoundButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game_loop');
              },
              text: Text(
                'New Game',
                style:
                    TextStyle(color: Colors.black87, fontSize: block * 5),
              ),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.black87,
              ),
              size: (100.0 / block) * block,
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
                  icon: Icon(
                    Icons.navigate_next,
                    color: (isLoadGame) ? Colors.black : Colors.grey,
                  ),
                  size: block * (50.0 / block),
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
                  size: block * (50.0 / block),
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
                  size: block * (50.0 / block),
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
                  size: block * (50.0 / block),
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
                  size: block * (50.0 / block),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
