import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomButtom extends StatefulWidget {
  @override
  _CustomButtomState createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
      ),
    );
  }
}

class ClippedButton extends StatelessWidget {
  const ClippedButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
        child: Container(
          height: 45.0,
          width: 250.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            
          ),
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: () {},
            child: null,
          ),
        ),
      ),
    );
  }
}
