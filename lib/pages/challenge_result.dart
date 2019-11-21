import 'dart:ui';

import 'package:flutter/material.dart';
import '../constants.dart';
import '../query.dart';

class ChallegeResult extends StatefulWidget {
  ChallegeResult({Key key, this.gameresult = '', this.list, this.finishTime})
      : super(key: key) {
    print(list);
  }
  final String gameresult;
  final List<String> list;
  final int finishTime;
  @override
  _ChallegeResultState createState() => _ChallegeResultState();
}

class _ChallegeResultState extends State<ChallegeResult> {
  String hasCompleted = 'You did it!';
  String betterluck = 'Better luck next time';
  String winner;
  Color resColor;

  String getWinner() {
    if (widget.gameresult == 'success') {
      resColor = Colors.green;
      return hasCompleted;
    } else if (widget.gameresult == 'fail') {
      resColor = Colors.red;
      return betterluck;
    }
  }

  @override
  void initState() {
    winner = getWinner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    double hr = Query.heightRatio;
    double wr = Query.widthRatio;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kiBg2),
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomLeft,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Elapsed Time: ${widget.finishTime.toString()} seconds',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: block * 4,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          offset: Offset(3.0, 3.0),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: block * 3,),
                Container(
                  height: 50.0 * hr,
                  width: 50.0 * widget.list.length * wr,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.list.length,
                    itemBuilder: (context, i) {
                      return ResTile(
                        av: widget.list[i],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40.0 * hr,
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 20,
                    margin: EdgeInsets.all(8.0),
                    color: resColor,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          winner,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: block * 5,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 5.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0 * hr,
                ),
                RaisedButton(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.orange,
                  child: Container(
                    width: 200 * wr,
                    height: 50 * hr,
                    child: Center(
                      child: Text(
                        'New Game',
                        style: TextStyle(
                          fontSize: Query.block * 3.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => LevelPage(gameplay: widget.gametype,)),
                    // );
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResTile extends StatelessWidget {
  final String av;
  ResTile({this.av});

  Widget getAvatar(String avatar) {
    switch (avatar) {
      case 'empty':
        return Container();
        break;
      case 'frog':
        return Image(
          image: AssetImage(kiFrog),
        );
        break;
      case 'toad':
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
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3.0, color: Colors.white54),
          color: Colors.white54),
      width: 50.0 * Query.widthRatio,
      height: 50.0 * Query.heightRatio,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: getAvatar(av),
      ),
    );
  }
}
