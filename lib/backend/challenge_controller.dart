import 'package:flutter/material.dart';

import 'enums.dart';

class GameControl extends ChangeNotifier {
  static String toad = 'toad';
  static String frog = 'frog';
  static String empty = 'empty';
  static String continueGame = 'continue';
  static String endGame = 'end';

  List<AvatarAnim> animations;
  List<String> list;

  String state, result;
  int leafs, frogs, toads;
  bool canTap;

  GameControl({this.leafs = 9, this.frogs = 4, this.toads = 4}) {
    list = List<String>();
    animations = List<AvatarAnim>();
    initialize();
  }

  void initialize() {
    for (int i = 0; i < frogs; i++) list.add(frog);
    for (int i = 0; i < leafs - frogs - toads; i++) list.add(empty);
    for (int i = 0; i < toads; i++) list.add(toad);
    for (int i = 0; i < leafs; i++) animations.add(AvatarAnim.noanim);
    canTap = true;
    state = continueGame;
  }

  String get gameState => state;

  bool canMove() {
    bool can = false;
    for (int i = 0; i < leafs; i++) {
      int cur = i, prev = i - 1, next = i + 1;
      if (list[cur] == frog && next < list.length) {
        if (list[next] == empty) {
          can = true;
        } else if (list[next] == toad && next + 1 < list.length) {
          if (list[next + 1] == empty) {
            can = true;
          }
        }
      } else if (list[cur] == toad && prev >= 0) {
        if (list[prev] == empty) {
          can = true;
        } else if (list[prev] == frog &&
            prev - 1 >= 0 &&
            list[prev - 1] == empty) {
          can = true;
        }
      }
    }
    return can;
  }

  bool hasCompleted() {
    bool toaddone = true;
    bool frogdone = true;
    for (int i = 0; i < toads; i++) {
      if (list[i] != toad) {
        toaddone = false;
      }
    }
    for (int i = leafs - frogs; i < leafs; i++) {
      if (list[i] != frog) {
        frogdone = false;
      }
    }
    return toaddone && frogdone;
  }

  void checkState() {
    if (!canMove()) {
      state = endGame;
      if (hasCompleted()) {
        result = 'success';
      } else
        result = 'fail';
      print(result);
    } else {
      state = continueGame;
    }
  }

  void swapAvatar(int av1, int av2) {
    String temp = list[av1];
    list[av1] = list[av2];
    list[av2] = temp;
    notifyListeners();
  }

  void frogJumpa(int cur, int next) {
    animations[cur] = AvatarAnim.jumpNext;
    notifyListeners();
    // animation will happen wait 500 ms for it then swap:
    Future.delayed(Duration(milliseconds: 500), () {
      canTap = true;
      swapAvatar(cur, next);
      checkState();
    });
  }

  void frogHopa(int cur, int next) {
    animations[cur] = AvatarAnim.hopNext;
    notifyListeners();
    // animation will happen wait 800 ms for it then swap:
    Future.delayed(Duration(milliseconds: 800), () {
      canTap = true;
      swapAvatar(cur, next + 1);
      checkState();
    });
  }

  void toadJumpa(int cur, int prev) {
    animations[cur] = AvatarAnim.jumpPrev;
    notifyListeners();
    // animation will happen wait 500 ms for it then swap:
    Future.delayed(Duration(milliseconds: 500), () {
      canTap = true;
      swapAvatar(cur, prev);
      checkState();
    });
  }

  void toadHopa(int cur, int prev) {
    animations[cur] = AvatarAnim.hopPrev;
    notifyListeners();
    // animation will happen wait 800 ms for it then swap:
    Future.delayed(Duration(milliseconds: 800), () {
      canTap = true;
      swapAvatar(cur, prev - 1);
      checkState();
    });
  }

  void onTap(int index) {
    int cur = index, prev = index - 1, next = index + 1;
    if (canTap) if (list[cur] == frog && next < list.length) {
      if (list[next] == empty) {
        canTap = false;
        frogJumpa(cur, next);
      } else if (list[next] == toad && next + 1 < list.length) {
        if (list[next + 1] == empty) {
          canTap = false;
          frogHopa(cur, next);
        }
      }
    } else if (list[cur] == toad && prev >= 0) {
      if (list[prev] == empty) {
        canTap = false;
        toadJumpa(cur, prev);
      } else if (list[prev] == frog &&
          prev - 1 >= 0 &&
          list[prev - 1] == empty) {
        canTap = false;
        toadHopa(cur, prev);
      }
    }
  }
}
