import 'package:flutter/foundation.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/score.dart';

class MultiGameController extends ChangeNotifier {
  int frogs, toads, leafs;

  List<TileAvatar> _avatarList = List<TileAvatar>();

  bool hasFrog, hasToad, frogFirst;

  MultiGameController({
    this.frogs = 3,
    this.toads = 3,
    this.leafs = 12,
    this.frogFirst = false,
  }) {
    resetGame();
  }
  Future resetGame() async {
    for (int i = 0; i < frogs; i++) _avatarList.add(TileAvatar.frog);
    for (int i = 0; i < leafs - toads - frogs; ++i)
      _avatarList.add(TileAvatar.empty);
    for (int i = 0; i < toads; i++) _avatarList.add(TileAvatar.toad);

    if (frogFirst) {
      hasFrog = false;
      hasToad = true;
    } else {
      hasToad = true;
      hasFrog = false;
    }
  }

  int getAvatarListLength() {
    return _avatarList.length;
  }

  TileAvatar avatarAt(int i) => _avatarList[i];

  void setAvatarAt(int i, TileAvatar val) {
    _avatarList[i] = val;
    notifyListeners();
  }

  List<TileAvatar> get list => _avatarList;

  int whoWon() {
    int hasToadWon = 1;
    int hasFrogWon = 1;
    for (int i = 0; i < leafs; i++) {
      int cur = i, prev = i - 1, next = i + 1;
      if (list[cur] == TileAvatar.frog && next < list.length) {
        if (list[next] == TileAvatar.empty) {
          hasToadWon *= 0;
        } else if (list[next] == TileAvatar.toad && next + 1 < list.length) {
          if (list[next + 1] == TileAvatar.empty) {
            hasToadWon *= 0;
          }
        }
      } else if (list[cur] == TileAvatar.toad && prev >= 0) {
        if (list[prev] == TileAvatar.empty) {
          hasFrogWon *= 0;
        } else if (list[prev] == TileAvatar.frog &&
            prev - 1 >= 0 &&
            list[prev - 1] == TileAvatar.empty) {
          hasFrogWon *= 0;
        }
      }
    }
    if (hasToadWon == 1) {
      return 2;
    }
    else if (hasFrogWon == 1) {
      return 1;
    }
    else {
      return 0;
    }
  }

  String turn () {
    if (hasToad && !hasFrog) return 'Frog\'s Turn';
    else return 'Toad\'s Turn';
  }
  void onDoubleTapped(int index, Score scr) {
    int cur = index, prev = index - 1, next = index + 1;
    if (hasToad &&
        !hasFrog &&
        list[cur] == TileAvatar.frog &&
        next < list.length) {
      if (list[next] == TileAvatar.empty) {
        hasFrog = true;
        hasToad = false;
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(next, TileAvatar.frog);
      } else if (list[next] == TileAvatar.toad && next + 1 < list.length) {
        if (list[next + 1] == TileAvatar.empty) {
          hasFrog = true;
          hasToad = false;
          scr.incrementHop(TileAvatar.frog);
          setAvatarAt(cur, TileAvatar.empty);
          setAvatarAt(next + 1, TileAvatar.frog);
        }
      }
    } else if (!hasToad &&
        hasFrog && list[cur] == TileAvatar.toad && prev >= 0) {
      if (list[prev] == TileAvatar.empty) {
        hasFrog = false;
        hasToad = true;
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(prev, TileAvatar.toad);
      } else if (list[prev] == TileAvatar.frog &&
          prev - 1 >= 0 &&
          list[prev - 1] == TileAvatar.empty) {
        hasFrog = false;
        hasToad = true;
        scr.incrementHop(TileAvatar.toad);
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(prev - 1, TileAvatar.toad);
      }
    }
  }
  
}
