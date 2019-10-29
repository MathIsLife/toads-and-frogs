import 'package:flutter/foundation.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/pages/game_screen.dart';


class GameController extends ChangeNotifier {
  static int SIZE = 12;
  static const int USER_WON = 1;
  static const int COMPUTER_WON = 2;
  static const int CONTINUE_GAME = 3;
  static const int EASY = 1;
  static const int HARD = 2;

  int gameDifficulty = HARD;
  int frogs , toads, leafs;

  int gameState = CONTINUE_GAME;
  List<TileAvatar> _avatarList = List<TileAvatar>();

  // TODO: where will be frogs and where will be toads
  GameController({this.gameDifficulty = HARD, this.frogs = 3, this.leafs = 12}) {
    toads = frogs;
    resetGame();
  }
  void resetGame() {
    SIZE = leafs;
    for(int i = 0; i<frogs; i++)
    _avatarList.add(TileAvatar.frog);
  
    for (int i = 0; i < leafs - toads - frogs; ++i) {
      _avatarList.add(TileAvatar.empty);
    }
    for(int i = 0; i<toads; i++)
    _avatarList.add(TileAvatar.toad);
    
    fireUpDP();
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

  /*
     |\   |  `|` |``\  ```|` |   |  /```\  |``\
     | \  |   |  |__/     |  |___| |     | |__/
     |  \ |   |  |  \     |  |   | |     | |  \
    _|   \|  _|_ |   \ \__)  |   |  \___/  |   \
    
*/

  List <int> maskToList (int mask) {
    List <int> ret = List <int> ();
    for (int i = 0; i < SIZE; ++i, mask ~/= 3) {
      ret.add(mask % 3);
    }
    return ret;
  }

  int listToMask (List <int> list) {
    int mask = 0;
    for (int i = SIZE - 1; i >= 0; --i) {
      mask = mask * 3 + list[i];
    }
    return mask;
  }

  int lim = 1;
  List <int> dp = List <int> ();
  List <int> parent = List <int> ();

  int isWinning (int mask) {
    if (dp[mask] != -1) return dp[mask];
    dp[mask] = 0;
    List <int> list = maskToList(mask);
    for (int i = 0; i + 1 < SIZE; ++i) {
      if (list[i] == 1) {
        if (list[i + 1] == 0) {
          List <int> newList = []..addAll(list);
          int tmp = newList[i];
          newList[i] = newList[i + 1];
          newList[i + 1] = tmp;
          newList = newList.reversed.toList();
          for (int j = 0; j < SIZE; ++j) {
            if (newList[j] != 0) newList[j] = 3 - newList[j];
          }
          int to_mask = listToMask(newList);
          if (isWinning(to_mask) == 0) {
            dp[mask] = 1;
            parent[mask] = i;
            break;
          }
        }
        if (i + 2 < SIZE && list[i + 1] == 2 && list[i + 2] == 0) {
          List <int> newList = []..addAll(list);
          int tmp = newList[i];
          newList[i] = newList[i + 2];
          newList[i + 2] = tmp;
          newList = newList.reversed.toList();
          for (int j = 0; j < SIZE; ++j) {
            if (newList[j] != 0) newList[j] = 3 - newList[j];
          }
          int to_mask = listToMask(newList);
          if (isWinning(to_mask) == 0) {
            dp[mask] = 1;
            parent[mask] = i;
            break;
          }
        }
      }
    }
    return dp[mask];
  }

  // compute optimal moves using dynamic programming
  void fireUpDP() {
    for (int i = 0; i < SIZE; ++i) {
      lim *= 3;
    }
    for (int i = 0; i < lim; ++i) {
      dp.add(-1); 
      parent.add(-1);
    }
  }

  int computerMove() {
    List <int> now = List <int> ();
    for (int i = SIZE - 1; i >= 0; --i) {
      if (_avatarList[i] == TileAvatar.empty) now.add(0);
      if (_avatarList[i] == TileAvatar.frog) now.add(2);
      if (_avatarList[i] == TileAvatar.toad) now.add(1);
    }
    int mask = listToMask(now), pos, oth;
    print(now);
    print(mask);
    print(isWinning(mask));

    if (gameDifficulty == EASY || isWinning(mask) == 0) {
      List <int> validMoves = List <int> ();
      for (int i = 1; i < SIZE; ++i) {
        if (_avatarList[i] == TileAvatar.toad) {
          if (_avatarList[i - 1] == TileAvatar.empty) {
            validMoves.add(i);
          } else if (i > 1 && _avatarList[i - 1] == TileAvatar.frog && _avatarList[i - 2] == TileAvatar.empty) {
            validMoves.add(i);
          }
        }
      }

      if (validMoves.isEmpty) {
        who = 1;
        return USER_WON;
      }

      validMoves.shuffle();
      pos = validMoves[0];
    } else {
      pos = SIZE - 1 - parent[mask];
    }

    if (_avatarList[pos - 1] == TileAvatar.empty) oth = pos - 1;
    else oth = pos - 2;
    TileAvatar tmp = _avatarList[oth];
    _avatarList[oth] = _avatarList[pos];
    _avatarList[pos] = tmp;
    for (int i = 0; i < SIZE - 1; ++i) {
      if (_avatarList[i] == TileAvatar.frog) {
        if (_avatarList[i + 1] == TileAvatar.empty) {
          return CONTINUE_GAME;
        } else if (i + 2 < SIZE && _avatarList[i + 1] == TileAvatar.toad && _avatarList[i + 2] == TileAvatar.empty) {
          return CONTINUE_GAME;  
        }
      }
    }
    who = 2;
    return COMPUTER_WON;
  }

  void onDoubleTapped(int index, Score scr) {
    int cur = index, prev = index - 1, next = index + 1;
    bool hasGiven = false;
    if (list[cur] == TileAvatar.frog && next < list.length) {
      if (list[next] == TileAvatar.empty) {
        hasGiven = true;
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(next, TileAvatar.frog);
      } else if (list[next] == TileAvatar.toad && next + 1 < list.length) {
        if (list[next + 1] == TileAvatar.empty) {
          hasGiven = true;
          scr.incrementHop(TileAvatar.frog);
          setAvatarAt(cur, TileAvatar.empty);
          setAvatarAt(next + 1, TileAvatar.frog);
        }
      }
      if (hasGiven) {
        gameState = computerMove();
      }
    }
    // else if (list[cur] == TileAvatar.toad && prev >= 0) {
    //   if (list[prev] == TileAvatar.empty) {
    //     setAvatarAt(cur, TileAvatar.empty);
    //     setAvatarAt(prev, TileAvatar.toad);
    //   } else if (list[prev] == TileAvatar.frog &&
    //       prev - 1 >= 0 &&
    //       list[prev - 1] == TileAvatar.empty) {
    //     scr.incrementHop(TileAvatar.toad);
    //     setAvatarAt(cur, TileAvatar.empty);
    //     setAvatarAt(prev - 1, TileAvatar.toad);
    //   }
    // }
  }
}

