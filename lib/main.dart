import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toads_and_frogs/pages/test_first_page.dart';


Future main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: First(),
    );
  }
}
