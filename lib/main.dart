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

  Widget getApp() {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        FirstPage.route: (context) => FirstPage(),
        GameScreen.route: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  builder: (context) => GameController(),
                ),
                ChangeNotifierProvider(
                  builder: (context) =>  Score(),
                )
              ],
              child: GameScreen(),
            ),
        GameResult.route: (context) => GameResult(),
      },
    );
  }

  runApp(getApp());
}
