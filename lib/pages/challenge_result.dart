import 'package:flutter/material.dart';


class ChallegeResult extends StatefulWidget {
  ChallegeResult({Key key, this.gameresult = '', this.list}) : super(key: key);
  final String gameresult;
  final List<String> list;
  @override
  _ChallegeResultState createState() => _ChallegeResultState();
}

class _ChallegeResultState extends State<ChallegeResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(widget.gameresult, style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}
