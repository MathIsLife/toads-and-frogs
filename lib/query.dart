import 'package:flutter/material.dart';

class Query {
  static var mediaQuery;
  static Size screenSize;
  static double width, height;
  static double block;
  static double hBox = 100.0, vBox;

  static void loadAll(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenSize = mediaQuery.size;
    width = screenSize.width;
    height = screenSize.height;
    block = width / hBox;
    vBox = height/ block;
  }
}
