import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Player extends StatelessWidget {
  const Player({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Hero(
              child: Material(
                color: Colors.black,
                child: ListTile(
                  leading: Image.asset('assets/covers/4.jpg'),
                  title: Text(
                    'Get Lucky',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Daft Punk',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              tag: 'cover',
            ),
            new MySlider()
          ],
        ),
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  const MySlider({
    Key key,
  }) : super(key: key);

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double value = 0;

  @override
  void initState() {  

    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
       value = value + 1; 
      });
    });
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 100,
      onChanged: (double value) {},
      value: value,
    );
  }
}
