import 'package:flutter/material.dart';

/// Template for a [FlipBoxBar] item.
class FlipBarItem {
  /// The icon to be displayed on the sides (Can be replaced by any other widget).
  final Widget iconTop;

  final Widget iconBottom;

  /// The text to be displayed when item is selected (Can be replaced by any other widget).
  final Widget textTop;

  final Widget textBottom;

  /// The color of the front side (Originally towards the user).
  final Color frontColor;

  /// The color of the top side (Towards the user when selected).
  final Color backColor;

  FlipBarItem({
    @required this.iconTop,
    @required this.iconBottom,
    @required this.textTop,
    @required this.textBottom,
    this.frontColor = Colors.blueAccent,
    this.backColor = Colors.blue,
  });
}
