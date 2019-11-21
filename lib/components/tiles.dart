import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/multi_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/pages/game_result.dart';
import 'package:toads_and_frogs/query.dart';

import '../constants.dart';

class Tile extends StatelessWidget {
  static int count = 0;
  final int index;
  final int gameplay;
  Tile({
    this.index,
    this.gameplay = 1,
  }) {
    //print('${++count}');
  }

  Widget getAvatar(TileAvatar avatar) {
    switch (avatar) {
      case TileAvatar.empty:
        return Container();
        break;
      case TileAvatar.frog:
        return Circle(
          index: index,
          child: Image(
            image: AssetImage(kiFrog),
          ),
        );
        break;
      case TileAvatar.toad:
        return Circle(
          index: index,
          child: Image(
            image: AssetImage(kiToad),
          ),
        );
        break;
      default:
        return Container();
    }
  }

  Future<void> gotoResultMul(BuildContext context) async {
    var gc = Provider.of<MultiGameController>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () {
      int whoWon = gc.whoWon();
      if (whoWon != 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameResult(
              whoWon: whoWon + 2,
              list: gc.list,
            ),
          ),
        );
        // gc.dispose();
        // Provider.of<Score>(context).dispose();
      }
    });
  }

  Future<void> gotoResult(context) async {
    var gc = Provider.of<GameController>(context, listen: false);
    Future.delayed(Duration(seconds: 2), () {
      if (gc.gameState != GameController.CONTINUE_GAME) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameResult(
              whoWon: gc.gameState,
              list: gc.list,
            ),
          ),
        );
        // gc.dispose();
        // Provider.of<Score>(context).dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    final Score scr = Provider.of<Score>(context);

    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: block * 9,
            width: block * 9,
            child: Image(
              image: AssetImage(kiLeaf2),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              if (gameplay == 1) {
                Provider.of<GameController>(context,)
                    .onDoubleTapped(index, scr);
                gotoResult(context);
              } else {
                Provider.of<MultiGameController>(context, )
                    .onDoubleTapped(index, scr);
                gotoResultMul(context);
              }
            },
            child: Container(
              margin: EdgeInsets.all(0),
              height: block * 7,
              width: block * 7,
              child: getAvatar((gameplay == 1)
                  ? Provider.of<GameController>(context).list[index]
                  : Provider.of<MultiGameController>(context).list[index]),
            ),
          )
        ],
      ),
    );
  }
}

class Circle extends StatefulWidget {
  Circle({
    Key key,
    this.index,
    this.child,
  }) : super(key: key);
  final int index;
  final Widget child;

  @override
  _CircleState createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  AnimationController jumpController, hopController, controller;
  Animation jumpNext, hopNext, jumpPosX, jumpPrev, hopPrev;
  int index;
  double block = Query.block;
  double containerWidth = 100.0 + 8.0; // initial value, will be changed
  double r = 50.0;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    containerWidth = block * 11;
    r = 5.5 * block;
    jumpController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    hopController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    jumpNext = Tween(begin: 0.0, end: containerWidth).animate(jumpController);
    hopNext = Tween(begin: 0.0, end: 2 * containerWidth).animate(hopController);
    jumpPrev = Tween(begin: 0.0, end: -containerWidth).animate(jumpController);
    hopPrev =
        Tween(begin: 0.0, end: -2 * containerWidth).animate(hopController);
  }

  Animation getAnimation(AvatarAnim an) {
    Animation animations;
    if (an == AvatarAnim.hopNext) {
      animations = hopNext;
      r = containerWidth;
      controller = hopController;
    } else if (an == AvatarAnim.jumpNext) {
      animations = jumpNext;
      r = containerWidth / 2.0;
      controller = jumpController;
    } else if (an == AvatarAnim.hopPrev) {
      animations = hopPrev;
      r = -containerWidth;
      controller = hopController;
    } else if (an == AvatarAnim.jumpPrev) {
      animations = jumpPrev;
      r = -containerWidth / 2.0;
      controller = jumpController;
    } else if (an == AvatarAnim.noanim) {
      controller = jumpController;
      animations = Tween(begin: 0.0, end: 0.0).animate(jumpController);
    }
    return animations;
  }

  @override
  void dispose() {
    jumpController.dispose();
    hopController.dispose();
    controller ?? dispose();
    super.dispose();
  }

  void gotoResult(BuildContext context, String result, List<String> list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameResult(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    Animation anim = getAnimation(gc.animations[index]);

    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        if (gc.animations[index] != AvatarAnim.noanim) {
          gc.animations[index] = AvatarAnim.noanim;
          controller.forward();
        }
        double x = anim.value;
        double y = -math.sqrt(r * r - (x - r) * (x - r));

        return Transform.translate(
          offset: Offset(x, y * 1.3),
          child: Container(
            height: 7 * block,
            width: 7 * block,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
