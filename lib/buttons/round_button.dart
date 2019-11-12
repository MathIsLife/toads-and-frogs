import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({@required this.onPressed, this.icon, this.tooltip, this.size = 50, this.color = Colors.amberAccent});
  final Function onPressed;
  final String tooltip;
  final Icon icon;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color:color,
        child: Center(
          child: IconButton(
            padding: EdgeInsets.all(0.0),
            tooltip: tooltip,
            icon: icon,
            iconSize: size / 1.5,
            onPressed: onPressed,
            
            splashColor: Colors.amberAccent,
          ),
        ),
      ),
    );
  }
}
