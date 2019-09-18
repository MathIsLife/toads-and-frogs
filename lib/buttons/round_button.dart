import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({@required this.onPressed, this.icon, this.text, this.size});
  final Function onPressed;
  final Text text;
  final Icon icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Container(
              width: (size == null) ? 50.0 : size,
              height: (size == null) ? 50.0 : size,
              color: Colors.amber,
              child: IconButton(
                icon: icon,
                iconSize: (size == null) ? 30.0 : 1.5 * size / 2,
                onPressed: onPressed,
                splashColor: Colors.amberAccent,
         
              ),
            ),
          ),
        ],
      ),
    );
  }
}
