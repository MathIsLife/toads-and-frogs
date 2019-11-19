import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/query.dart';
import '../constants.dart';

class ChallengeTile extends StatelessWidget {
  static int count = 0;
  final int index;

  ChallengeTile({
    this.index,
  });
  
  Widget getAvatar(TileAvatar avatar) {
    switch (avatar) {
      case TileAvatar.empty:
        return Container();
        break;
      case TileAvatar.frog:
        return Image(
          image: AssetImage(kiFrog),
        );
        break;
      case TileAvatar.toad:
        return Image(
          image: AssetImage(kiToad),
        );
        break;
      default:
        return Container();
    }
  }

  Future<void> gotoResult(context) async {
    
  }

  @override
  Widget build(BuildContext context) {
    double block = Query.block;
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: block * 9,
            width: block * 9,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white10, width: q.block * 0.7),
            //   borderRadius: BorderRadius.circular(20.0),
            // ),
            child: Image(
              image: AssetImage(kiLeaf2),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              
            },
            child: Container(
              margin: EdgeInsets.all(0),
              height: block * 7,
              width: block * 7,
              child: getAvatar(list[index]),
            ),
          )
        ],
      ),
    );
  }
}
