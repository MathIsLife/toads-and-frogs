import 'package:flutter/foundation.dart';
import 'package:toads_and_frogs/backend/enums.dart';
import 'package:toads_and_frogs/backend/score.dart';

class GameController extends ChangeNotifier {
  List<TileAvatar> _avatarList = List<TileAvatar>();

  // TODO: where will be frogs and where will be toads
  GameController() {
    _avatarList.addAll([
      TileAvatar.frog,
      TileAvatar.toad,
      TileAvatar.frog,
      TileAvatar.empty,
      TileAvatar.frog,
      TileAvatar.empty,
      TileAvatar.toad,
      TileAvatar.empty,
      TileAvatar.toad,
      TileAvatar.empty,
      TileAvatar.frog,
      TileAvatar.toad
    ]);
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

  void onDoubleTapped(int index, Score scr) {
    int cur = index, prev = index - 1, next = index + 1;
    if (list[cur] == TileAvatar.frog && next < list.length) {
      if (list[next] == TileAvatar.empty) {
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(next, TileAvatar.frog);
      } else if (list[next] == TileAvatar.toad && next + 1 < list.length) {
        if (list[next + 1] == TileAvatar.empty) {
          scr.incrementHop(TileAvatar.frog);
          setAvatarAt(cur, TileAvatar.empty);
          setAvatarAt(next + 1, TileAvatar.frog);
        }
      }
    } else if (list[cur] == TileAvatar.toad && prev >= 0) {
      if (list[prev] == TileAvatar.empty) {
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(prev, TileAvatar.toad);
      } else if (list[prev] == TileAvatar.frog &&
          prev - 1 >= 0 &&
          list[prev - 1] == TileAvatar.empty) {
        scr.incrementHop(TileAvatar.toad);
        setAvatarAt(cur, TileAvatar.empty);
        setAvatarAt(prev - 1, TileAvatar.toad);
      }
    }
  }
}
