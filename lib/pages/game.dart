import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toads_and_frogs/components/tiles.dart';

class MyGame extends Game {
  // screen size , screen's widt and height
  Size screenSize;
  double screenWidth, screenHeight;

  // screen Background rectangle, TODO: add a background picture
  Rect bgRect;
  Paint bgPaint;

  // size and properties of tiles where frogs will be placed
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

    //initializing tiles
    totalTiles = 12;
    gap = screenWidth / 15.0;
    totalScreenWidth = totalTiles * (gap + tileSize) + 10.0;
    double tx = tileSize / 2.0;
    double ty = screenHeight / 2.0 - tileSize / 2.0;
    tiles = List<Tile>();
    for (int i = 0; i < totalTiles; i++) {
      tiles.add(Tile(this, tx, ty, i));
      tx = tx + tileSize + gap;
    }

    //adding gestures
    tapper = TapGestureRecognizer();
    tapper.onTapDown = this.onTapDown;
    Flame.util.addGestureRecognizer(tapper);

    drag = HorizontalDragGestureRecognizer()
      ..onDown = this.onDragDown
      ..onStart = this.onDragStart
      ..onUpdate = this.onDragUpdate
      ..onEnd = this.onDragEnd;
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

  void onDragDown(DragDownDetails dd) {
    print("down");
  }

  void onDragEnd(DragEndDetails de) {
    print('end!');
  }

  void onDragUpdate(DragUpdateDetails du) {
    tiles.forEach((Tile t) {
      t.shiftEm(du.delta);
    });
  }

  void onDragStart(DragStartDetails ds) {
    print('start!');
  }

  void resize(Size size) {
    screenSize = size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    tileSize = screenWidth / 9.0;
  }
}
