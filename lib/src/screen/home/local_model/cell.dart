// import 'dart:convert';
// https://app.quicktype.io/

import 'package:memory_game/src/application.dart';

class Cell {
  static double width = getWidth(100) / 5;
  static double height = getWidth(100) / 5;

  AnimationController? controller;
  bool isShown = true;
  bool clickable = false;

  final String image;

  Cell(this.image);
}
