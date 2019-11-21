import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/challenge_controller.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/pages/challenge_result.dart';

import '../query.dart';

class ChallengeTile extends StatelessWidget {
  final int index;
  ChallengeTile({@required this.index});

  Widget getChild(String av, int i) {
    switch (av) {
      case 'frog':
        return Circle(index: i, child: Image(image: AssetImage(kiFrog)));
        break;
      case 'toad':
        return Circle(index: i, child: Image(image: AssetImage(kiToad)));
        break;
      case 'empty':
        return Container();
        break;
      default:
        return Container();
    }
  }

  void gotoResult(BuildContext context, String result, List<String> list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChallegeResult(
          gameresult: result,
          list: list,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GameControl gc = Provider.of<GameControl>(context);
    double block = Query.block;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: 9 * block,
            width: 9 * block,
            child: Image(
              image: AssetImage(kiLeaf2),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: block * 2),
            height: 7 * block,
            width: 7 * block,
            child: getChild(gc.list[index], index),
          ),
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
        builder: (_) => ChallegeResult(
          gameresult: result,
          list: list,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GameControl gc = Provider.of<GameControl>(context);
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
          child: GestureDetector(
            onTap: () {
              gc.onTap(index);
            },
            child: Container(
              height: 14 * block,
              width: 14 * block,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
