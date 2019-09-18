
import 'package:flutter/material.dart';

class StackedButton extends StatelessWidget {
  Widget _buildSideButtons(
      BuildContext context, IconData icon, Color coverColor, EdgeInsets pad,
      {VoidCallback navigate}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          print("Pressed!");
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Container(
          child: Padding(
            padding: pad,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        color: coverColor,
        textColor: Colors.white,
      ),
    );
  } //widget

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSideButtons(
                context,
                Icons.settings,
                Colors.lime,
                const EdgeInsets.only(right: 30.0),
              ),
              _buildSideButtons(
                context,
                Icons.lightbulb_outline,
                Colors.greenAccent,
                const EdgeInsets.only(left: 30.0),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.225,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.lime, Colors.greenAccent],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.275,
            height: MediaQuery.of(context).size.height * 0.22,
            child: new RaisedButton(
              elevation: 0.0,
              color: Colors.white,
              child: new Text(
                "START",
                style: TextStyle(
                  fontFamily: "Bebas Neue",
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
              shape: CircleBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
