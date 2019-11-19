import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:toads_and_frogs/backend/levels.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/game_modes.dart';
import 'package:toads_and_frogs/pages/init_config.dart';
import 'package:toads_and_frogs/pages/level_page.dart';
import 'constants.dart';

Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );
  LevelData.loadData(); // gotta initialize once
  final Future<Database> database = openDatabase(
    path.join(await getDatabasesPath(), 'score.db'),
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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameMode(),
    );
  }

  @override
  void initState() {
    // Schedule a microtask that warms up the image cache with all of the style
    // sphinx images. This will run after the build method is executed, but
    // before the style sphinx is displayed.
    scheduleMicrotask(() {
      precacheImage(AssetImage(kiBg4), context);
      precacheImage(AssetImage(kiBg1), context);
      precacheImage(AssetImage(kiBg2), context);
      precacheImage(AssetImage(kiBg3), context);
      precacheImage(AssetImage(kiToad), context);
      precacheImage(AssetImage(kiFrog), context);
      precacheImage(AssetImage(kiLeaf), context);
      precacheImage(AssetImage(kiLeaf2), context);
    });
    super.initState();
  }
}
