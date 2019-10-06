import 'package:flutter/material.dart';

class Query {
  var mediaQuery;
  Size screenSize;
  double width, height;
  double block;
  double hBox = 100.0, vBox;

  Query(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenSize = mediaQuery.size;
    width = screenSize.width;
    height = screenSize.height;
    block = width / hBox;
    vBox = height/ block;
    print('$width ' '$height');
    print('$hBox' ' $vBox');
  }
}
