import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/screens/album/album.dart';
import 'package:vinyl/screens/code/code_screen.dart';
import 'package:vinyl/screens/home/home.dart';
import 'package:vinyl/screens/login/login.dart';
import 'package:vinyl/screens/phone_number/phone_number_screen.dart';
import 'package:vinyl/screens/welcome/welcome_screen.dart';
import 'package:vinyl/utils/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => Home());
      case albumRoute:
        return CupertinoPageRoute(builder: (context) => Album());
      case playerRoute:
        return MaterialPageRoute(builder: (context) => Album());
      case loginRoute:
        return MaterialPageRoute(builder: (context) => Login());
      case welcomeRoute:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case phoneNumberRoute:
        return MaterialPageRoute(builder: (context) => PhoneNumberScreen());
      case codeRoute:
        return MaterialPageRoute(builder: (context) => CodeScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('Improper route'),
                  ),
                ));
    }
  }
}