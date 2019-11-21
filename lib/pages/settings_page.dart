import 'package:flutter/material.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/query.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: Query.block * 5,
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Text(
                'Guess what they didn\'t do this simple task',
                style: TextStyle(
                  fontSize: 30.0,
                  wordSpacing: 7.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.white,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(kiAbeer),
                  ),
                ),
              ),
              SizedBox(width: 50 * Query.widthRatio,),
              Container(
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(kiNirjhor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
