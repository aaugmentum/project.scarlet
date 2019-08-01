import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/screens/album/album_screen.dart';
import 'package:vinyl/screens/login/code_screen.dart';
import 'package:vinyl/screens/home/home_screen.dart';
import 'package:vinyl/screens/login/phone_number_screen.dart';
import 'package:vinyl/screens/player/player.dart';
import 'package:vinyl/screens/login/welcome_screen.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/screens/splash.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case albumRoute:
        return CupertinoPageRoute(builder: (context) => AlbumScreen());
      case playerRoute:
        return MaterialPageRoute(builder: (context) => PlayerScreen());
      case splashRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());      
      //First start
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