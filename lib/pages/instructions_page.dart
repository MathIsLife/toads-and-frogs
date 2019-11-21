import 'package:flutter/material.dart';
import 'package:toads_and_frogs/constants.dart';
import 'package:toads_and_frogs/query.dart';

class InstructionPage extends StatefulWidget {
  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(kiBg3), fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Query.block * 5,
            ),
            Center(
              child: Container(
                width: Query.width / 1.2,
                height: Query.height - Query.block * 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    instructionDetails,
                    style: TextStyle(
                      fontSize: 30.0,
                      wordSpacing: 7.0,
                      color: Colors.white,
                      fontFamily: 'Indie Flower',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
