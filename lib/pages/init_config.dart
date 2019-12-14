import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/buttons/round_button.dart';
import 'package:toads_and_frogs/pages/game_screen.dart';

class InitConfig extends StatefulWidget {
  static String route = '/init_config';
  @override
  _InitConfigState createState() => _InitConfigState();
}

class _InitConfigState extends State<InitConfig> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Information(),
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(flex: 4, child: Difficulty()),
              Expanded(flex: 4, child: Leafs()),
              Expanded(flex: 4, child: ToadsFrogs()),
              StartGame(),
            ],
          ),
        ),
      ),
    );
  }
}

class StartGame extends StatelessWidget {
  const StartGame({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: FlatButton(
        color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                var inf = Provider.of<Information>(context, listen: false);
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      builder: (context) => GameController(
                        gameDifficulty: inf.difficulty,
                        frogs: inf.frogs,
                        leafs: inf.leafs,
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
        child: Text(
          'Lets Go!',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
    );
  }
}

class Information extends ChangeNotifier {
  int _difficulty = GameController.EASY;
  int _frogs = 2;
  int _leafs = 8;

  get frogs => _frogs;
  get leafs => _leafs;
  get difficulty => _difficulty;
  set frogs(val) => _frogs = val;
  set leafs(val) => _leafs = val;
  set difficulty(val) => _difficulty = val;

  void increLeafs() {
    leafs++;
  }

  void increFrogs() {
    frogs++;
  }

  void decreFrogs() {
    frogs--;
  }

  void decreLeaf() {
    leafs--;
  }
}

class Difficulty extends StatefulWidget {
  @override
  _DifficultyState createState() => _DifficultyState();
}

class _DifficultyState extends State<Difficulty> {
  Text easy = Text(
    'Easy',
    style: TextStyle(fontSize: 40, color: Colors.green),
  );

  Text hard = Text(
    'Hard',
    style: TextStyle(fontSize: 40, color: Colors.red),
  );

  Text diff;

  int difficulty;
  bool value = true;

  @override
  void initState() {
    diff = easy;
    difficulty = GameController.EASY;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Difficulty',
                style: TextStyle(color: Colors.amber, fontSize: 40),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SwitchListTile(
              title: diff,
              value: value,
              onChanged: (bool val) {
                setState(() {
                  if (val) {
                    value = val;
                    Provider.of<Information>(context).difficulty =
                        GameController.EASY;
                    difficulty = GameController.EASY;
                    diff = easy;
                  } else {
                    value = val;
                    Provider.of<Information>(context).difficulty =
                        GameController.HARD;
                    difficulty = GameController.HARD;
                    diff = hard;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Leafs extends StatefulWidget {
  @override
  _LeafsState createState() => _LeafsState();
}

class _LeafsState extends State<Leafs> {
  int minLeaf = 7;
  int maxLeaf = 20;

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<Information>(context, listen: false);
    int leafNumber = info.leafs;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Leafs',
                style: TextStyle(fontSize: 40, color: Colors.amber),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '${leafNumber.toString()}',
                  style: TextStyle(fontSize: 40, color: Colors.amber),
                ),
                RoundButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (leafNumber < maxLeaf) {
                        Provider.of<Information>(context).increLeafs();
                        leafNumber++;
                      }
                    });
                  },
                ),
                RoundButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (leafNumber > minLeaf) {
                        Provider.of<Information>(context).decreLeaf();
                        leafNumber--;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToadsFrogs extends StatefulWidget {
  @override
  _ToadsFrogsState createState() => _ToadsFrogsState();
}

class _ToadsFrogsState extends State<ToadsFrogs> {
  int maxFrog = 5;
  int minFrog = 1;

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<Information>(context);
    int frogNumber = info.frogs;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Frogs',
                style: TextStyle(fontSize: 40, color: Colors.amber),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '${frogNumber.toString()}',
                  style: TextStyle(fontSize: 40, color: Colors.amber),
                ),
                RoundButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (frogNumber < maxFrog) {
                        info.increFrogs();
                      }
                    });
                  },
                ),
                RoundButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (frogNumber > minFrog) {
                        info.decreFrogs();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
