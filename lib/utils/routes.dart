import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/screens/home/home.dart';
import 'package:vinyl/screens/login/login.dart';
import 'package:vinyl/utils/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => Home());
      case loginRoute:
        return MaterialPageRoute(builder: (context) => Login());
      default:
        return MaterialPageRoute(builder: (context) => Scaffold(
          body: Center(
            child: Text('Improper route'),
          ),
        ));
    }
  }
}
