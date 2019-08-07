import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/models/global.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/styles.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      child: Container(
        color: appBarColor,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/flutter_logo.png',
          height: 100,
        ),
      ),
      builder: (BuildContext context, Global value, Widget child) {},
    );
  }
}
