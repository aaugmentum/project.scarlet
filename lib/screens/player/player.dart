import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vinyl/components/animated_play_button.dart';

const songs = [
  'Give Life Back To Music',
  'The Game Of Love',
  'Giorgio By Moroder',
  'Within',
  'Instant Crush',
  'Lose Yourself To Dance',
  'Touch',
  'Get Lucky',
  'Beyond',
  'Motherboard',
  'Fragments Of Time',
  'Doin\' It Right',
  'Contact'
];

class Player extends StatefulWidget {
  const Player({Key key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String _title;
  double _value;

  @override
  void initState() {
    super.initState();
    _value = 0.0;
    _title = songs[0];
  }

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
                    _title,
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
            MySlider(_value),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.backward, color: Colors.white70),
                  onPressed: () {},
                ),
                AnimatedPlayButton(size: 70),
                IconButton(
                  icon: Icon(FontAwesomeIcons.forward, color: Colors.white70),
                  onPressed: () {},
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: songs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _title = songs[index];
                        _value = 0.0;
                      });
                    },
                    leading: Container(
                      width: 20,
                      alignment: Alignment.center,
                      child: Text('${index + 1}', 
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ),
                    title: Text(
                      songs[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text('Random Access Memories',
                        style: TextStyle(color: Colors.white70)),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    indent: 65,
                    height: 1.0,
                    color: Colors.white30,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  final double value;

  const MySlider(
  this.value,
  {
    Key key,
  }) : super(key: key);

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _value;

  @override
  void initState() {
    _value = widget.value;
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _value = _value == 100 ? 0 : _value + 1;
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
      value: _value,
    );
  }
}
