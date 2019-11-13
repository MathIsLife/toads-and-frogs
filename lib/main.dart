import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toads_and_frogs/backend/levels.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/init_config.dart';
import 'package:toads_and_frogs/pages/level_page.dart';

Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );
  LevelData.loadData(); // gotta initialize once 
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'score.db'),
  );
  Widget getApp() {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        FirstPage.route: (context) => FirstPage(),
        InitConfig.route: (context) => InitConfig(),
        LevelPage.route: (context) => LevelPage(),
      },
    );
  }

  runApp(getApp());
}
