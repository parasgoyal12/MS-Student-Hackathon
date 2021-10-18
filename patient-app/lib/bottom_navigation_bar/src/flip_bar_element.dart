import 'package:flutter/material.dart';
import 'flip_box.dart';

/// Class for initialising the FlipBox
class FlipBarElement extends StatelessWidget {
  /// Passing down icon widget from upper widget
  final Widget iconTop;
  final Widget iconBottom;

  /// Passing down text widget from upper widget
  final Widget textTop;
  final Widget textBottom;

  /// Passing down widget from upper widget
  final Color frontColor;

  /// Passing down widget from upper widget
  final Color backColor;

  /// Passing down widget from upper widget
  final AnimationController controller;

  /// Passing down widget from upper widget
  final ValueChanged<int> onTapped;

  /// The index of the box.
  final index;

  /// Passing down widget from upper widget
  final double appBarHeight;

  FlipBarElement(this.iconTop, this.textTop,this.iconBottom,this.textBottom, this.frontColor, this.backColor,
      this.controller, this.onTapped, this.index, this.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return FlipBox(
      controller: controller,
      bottomChild: Container(
        width: double.infinity,
        height: double.infinity,
        //color: backColor,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            iconBottom,
            textBottom,
          ],
        ),
      ),
      topChild: Container(
        width: double.infinity,
        height: double.infinity,

        color: frontColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            iconTop,
            textTop,
          ],
        ),
      ),
      onTapped: () {
        onTapped(index);
      },
      height: appBarHeight,
    );
  }
}
