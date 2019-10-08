import 'package:flutter/material.dart';
import 'package:toads_and_frogs/backend/enums.dart';

class Score extends ChangeNotifier {
  int _frogHop = 0;
  int _toadHop = 0;

  int get frogHop => _frogHop;
  set frogHop(val) => _frogHop = val;

  int get toadHop => _toadHop;
  set toadHop(val) => _toadHop = val;

  void incrementHop(TileAvatar av) {
    if (av == TileAvatar.frog) {
      frogHop++;
      notifyListeners();
    }
    else if (av == TileAvatar.toad) {
      toadHop++;
      notifyListeners();
    }
    else {
      print('wtf');
    }
  }
}
