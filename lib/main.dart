import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toads_and_frogs/pages/first_page.dart';
import 'package:toads_and_frogs/pages/init_config.dart';

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
        InitConfig.route: (context) => InitConfig(),
      },
    );
  }

  runApp(getApp());
}
