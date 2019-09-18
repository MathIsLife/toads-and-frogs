import 'package:flutter/material.dart';

class OvalShapedButton extends StatelessWidget {
  OvalShapedButton({@required this.onPressed, this.child, this.color, this.height, this.width});
  final Function onPressed;
  final Widget child;
  final Color color;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: (width == null) ? 100.0 : width,
        width: (height == null) ? 100.0 : height,
        decoration: BoxDecoration(
          color: color
        ),
        child: FlatButton(
          child: child,
          clipBehavior: Clip.hardEdge,
          onPressed: onPressed,
        ),
      ),
    );
  }
}