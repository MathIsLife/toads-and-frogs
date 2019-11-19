import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/pages/level_page.dart';
import 'package:toads_and_frogs/query.dart';

class GameMode extends StatefulWidget {
  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  @override
  Widget build(BuildContext context) {
    Query.loadAll(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kiBg4),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Positioned(
            top: Query.block * 4,
            left: Query.block * 3,
            child: Container(
              width: Query.block * 10,
              height: Query.block * 10,
              child: RaisedButton(
                color: Colors.green,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
                shape: CircleBorder(),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FancyButton(
                  buttonText: 'Play vs Android',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LevelPage(gameplay: 1);
                      }),
                    );
                  },
                ),
                SizedBox(height: 10),
                FancyButton(
                  buttonText: 'Play vs Friend',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LevelPage(gameplay: 2);
                      }),
                    );
                  },
                ),
                SizedBox(height: 10),
                FancyButton(
                  buttonText: 'Challenge',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LevelPage(gameplay: 3);
                      }),
                    );
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

class FancyButton extends StatelessWidget {
  const FancyButton({
    Key key,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.green[800],
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          width: Query.block * 50,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontFamily: 'Indie Flower',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    offset: Offset(4, 4),
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
