import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toads_and_frogs/backend/levels.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'constants.dart';
//help me out
Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );
  LevelData.loadData(); // gotta initialize once

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
      home: FirstPage(),
    );
  }

  @override
  void initState() {
    scheduleMicrotask(() {
      precacheImage(AssetImage(kiAbeer), context);
      precacheImage(AssetImage(kiNirjhor), context);
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
