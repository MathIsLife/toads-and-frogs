import 'package:flutter/foundation.dart';
import 'package:toads_and_frogs/backend/enums.dart';


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
    _avatarList.length;
  }

  TileAvatar avatarAt(int i) => _avatarList[i];

  void setAvatarAt(int i, TileAvatar val) {
    _avatarList[i] = val;
    notifyListeners();
  }

  List<TileAvatar> get list => _avatarList;
  
}