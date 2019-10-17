import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/backend/score.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/game_result.dart';
import 'package:toads_and_frogs/pages/game_screen.dart';

Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );
  GameController gc = GameController();
  Score score = Score();

  Widget getApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => gc,
        ),
        ChangeNotifierProvider(
          builder: (context) => score,
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          FirstPage.route: (context) => FirstPage(),
          GameScreen.route: (context) => GameScreen(),
          GameResult.route: (context) => GameResult(),
        },
      ),
    );
  }

  runApp(getApp());
}
