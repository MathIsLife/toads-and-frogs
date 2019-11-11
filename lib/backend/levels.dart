import 'package:flutter/services.dart';
import 'dart:convert';

class Level {
  Level({this.level, this.difficulty, this.frogs, this.toads, this.userFirst, this.leafs});
  final int level;
  final int difficulty;
  final bool userFirst;
  final int toads, frogs, leafs;

  factory Level.fromMap(Map<String, dynamic> data) {
    return Level(
      difficulty: (data['diff'] == "easy") ? 1:2,
      level: data['level'],
      userFirst: (data['firstMove'] == "user") ? true : false,
      frogs: data['frogs'],
      toads: data['toads'],
      leafs: data['leafs'],
    );
  }
}

class LevelData {
  static List<Level> levels = List<Level>();
  static var data;
  static List<Map<String, dynamic>> levelData = List<Map<String, dynamic>>();

  static Future loadJSON() async {
    return await rootBundle.loadString('json/levels.json');
  }

  static void loadData() async {
    String jsonString = await loadJSON();
    final jsonRespone = await json.decode(jsonString);
    data = jsonRespone;
    for (int i = 0; i < 20; i++) {
      levelData.add(data[i]);
    }
    for (int i = 0; i < 20; i++) {
      levels.add(Level.fromMap(levelData[i]));
    }
  }
  
}
