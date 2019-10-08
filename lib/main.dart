import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toads_and_frogs/backend/game_controller.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/game_screen.dart';

Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );

  MaterialApp getApp() {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        FirstPage.route: (context) => FirstPage(),
        GameScreen.route: (context) => ChangeNotifierProvider(
              builder: (context) => GameController(),
              child: MaterialApp(
                home: GameScreen(),
              ),
            ),
      },
    );
  }

  runApp(getApp());
}
