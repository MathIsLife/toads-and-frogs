import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toads_and_frogs/pages/game.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/game_loop.dart';

Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );
  runApp(MaterialApp(home: GameLoop(),));
}

MaterialApp get app => MaterialApp(
      initialRoute: '/',
      routes: {
        FirstPage.route: (context) => FirstPage(),
        MyGame.route: (context) => MyGame().widget,
        GameLoop.route: (context) => GameLoop(),
      },
    );
