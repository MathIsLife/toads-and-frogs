import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toads_and_frogs/components/tiles.dart';

class MyGame extends Game {
  //routeName
  static String route = '/game_page';
  // screen size , screen's widt and height
  Size screenSize;
  double screenWidth, screenHeight;

  // screen Background rectangle, TODO: add a background picture
  Rect bgRect;
  Paint bgPaint;

  // size and properties of tiles where frogs will be placed
  double left, right;
  double tileSize;
  int totalTiles;
  double totalScreenWidth;
  List<Tile> tiles;
  double gap; // gap between each tiles

  //gestures
  TapGestureRecognizer tapper;
  HorizontalDragGestureRecognizer drag;

  MyGame() {
    init();
  }

  void init() async {
    resize(await Flame.util.initialDimensions());
    //setting up background
    bgRect = Rect.fromLTWH(0, 0, double.infinity, screenHeight);
    bgPaint = Paint()..color = Colors.white;

    //initializing tiles (maximum 10 ^ 5, for good fps 100)
    totalTiles = 9;
    gap = 10.0;
    totalScreenWidth = totalTiles * (gap + tileSize);
    double tx = tileSize / 2.0;
    double ty = screenHeight / 2.0 - tileSize / 2.0;
    tiles = List<Tile>();

    for (int i = 0; i < totalTiles; i++) {
      tiles.add(Tile(this, tx, ty, i));
      tx = tx + tileSize + gap;
    }

    left = tiles[0].tileRect.left;
    right = tiles[totalTiles - 1].tileRect.right;

    //adding gestures
    tapper = TapGestureRecognizer()..onTapDown = this.onTapDown;
    Flame.util.addGestureRecognizer(tapper);

    drag = HorizontalDragGestureRecognizer()
      ..onStart = null
      ..onEnd = this.onDragEnd
      ..onUpdate = this.onDragUpdate;
    Flame.util.addGestureRecognizer(drag);
  }

  // called at time of leaving this page
  void dispose() {
    tapper.dispose();
    drag.dispose();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(bgRect, bgPaint);
    tiles.forEach((Tile t) => t.render(canvas));
  }

  @override
  void update(double t) {}

  void onTapDown(TapDownDetails td) {}

  void onDragEnd(DragEndDetails de) {
    
  }

  void onDragUpdate(DragUpdateDetails du) {
    print(du.globalPosition.dx);
    tiles.forEach(
      (Tile t) {
        t.shiftEm(du.delta, left, right);
      },
    );
    left = tiles[0].tileRect.left;
    right = tiles[totalTiles - 1].tileRect.right;
  }

  void resize(Size size) {
    screenSize = size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    tileSize = screenWidth / 9.0;
  }
}
