import 'package:flutter/material.dart';
import 'package:toads_and_frogs/constants.dart';

class GameLoop extends StatefulWidget {
  static const String route = '/game_loop';
  final width = 100.0;
  final height = 120.0;
  @override
  _GameLoopState createState() => _GameLoopState();
}
List<bool> datas = List<bool>();
class _GameLoopState extends State<GameLoop> {
  // size and properties of tiles where frogs will be placed
  double left, right;
  double boxSize;
  int totalBoxes = 19;
  double totalScreenWidth;
  List<Widget> boxList = List<Widget>();
  double gap; // gap between each tiles


  void initState() {
    super.initState();
    createBoxList(totalBoxes);
  }

  void createBoxList(int n) {
    boxList.add(SizedBox(
      width: 40.0,
    ));
    datas.add(true);
    boxList.add(Box(id: 0,));
    for (int i = 1; i < n; i++) {
      datas.add(false);
      boxList.add(Box(id: i,));
    }
    boxList.add(SizedBox(
      width: 40.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Center(
            child: Text(
              'Score is 10',
              style: TextStyle(fontSize: 50.0),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: boxList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Box extends StatefulWidget {
  final width, height;
  final String amph;
  final id;

  Box({this.id,this.width = 100.0, this.height = 120.0, this.amph = 'toad'});
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> with AutomaticKeepAliveClientMixin {
  bool hasFrog;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    hasFrog = datas[widget.id];
    print(hasFrog);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: <Widget>[
        SizedBox(
          width: 100.0 * 0.2,
        ),
        Stack(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 120.0,
              child: Image(
                image: AssetImage(kiLeaf),
              ),
            ),
            Container(
              width: 100.0 * 0.8,
              height: 120.0 * 0.8,
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return hasFrog
                      ? Draggable(
                          data: 'frog',
                          child: Container(
                            width: 100 * .8,
                            height: 120 * .8,
                            child: Image(
                              image: AssetImage(kiFrog),
                            ),
                          ),
                          feedback: Container(
                            width: 100 * .8,
                            height: 120 * 0.8,
                            child: Image(
                              image: AssetImage(kiFrog),
                            ),
                          ),
                          childWhenDragging: Container(),
                          onDragCompleted: () {
                            setState(() {
                              hasFrog = false;
                            });
                          },
                        )
                      : Container();
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  hasFrog = true;
                },
              ),
            ),
          ],
        ),
        SizedBox(
          width: 100.0 * 0.2,
        )
      ],
    );
  }
}

