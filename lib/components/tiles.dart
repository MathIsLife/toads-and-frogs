import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:toads_and_frogs/pages/game.dart';

class Tile {
  double tileSize;
  double posX, posY;
  double textS;
  final MyGame game;
  Rect tileRect;
  Paint tilePaint;
  int tileId;
  TextConfig t;
  Rect textRect;
  

  Tile(this.game, this.posX, this.posY, this.tileId) {
    tileSize = game.tileSize;
    tileRect = Rect.fromLTWH(posX, posY, tileSize, tileSize);
    tilePaint = Paint()
      ..color = Colors.amber
      ..strokeWidth = tileSize * 0.05
      ..style = PaintingStyle.stroke;
    textS = game.screenWidth/100.0 * 5;
    print('$textS $tileSize');
    textRect = Rect.fromLTWH(posX, posY + tileSize + tileSize /10.0, tileSize/2, tileSize/2);
    t = TextConfig(fontSize: textS, color: Colors.deepOrange);
  }

  void render(Canvas c) {
    c.drawRect(tileRect, tilePaint);
    t.render(c, '${tileId + 1}', Position(posX + tileSize/2 -textS/2, posY + tileSize + tileSize / 10.0));
  }

  void update() {}

  void shiftEffect(double u, double fx, double lx) {

  }
  
  void shiftEm(Offset d, double fx, double lx) {
    if (d.dx > 0) {
      // moving right
      if (fx + d.dx < tileSize / 2) {
        tileRect = tileRect.shift(d);
        posX = tileRect.left;
        posY = tileRect.top;
        print('moving right');
      }
    } else {
      //moving left
      if (lx + d.dx > game.screenWidth - tileSize / 2) {
        tileRect = tileRect.shift(d);
        posX = tileRect.left;
        posY = tileRect.top;
        print('moving left');
      }
    }
  }
}
