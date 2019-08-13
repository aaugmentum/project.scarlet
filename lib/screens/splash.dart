import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/models/global.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/styles.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/constants.dart' as prefix0;
import 'package:vinyl/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) {
        print("The value is ${value.authorizationStatus}");
        if (value.authorizationStatus == AuthorizationStatus.WaitPhoneNumber || value.authorizationStatus == AuthorizationStatus.WaitCode || value.authorizationStatus == AuthorizationStatus.WaitPassword) {
          return MaterialApp(
            title: title,
            theme: ThemeData(primarySwatch: Colors.grey),
            initialRoute: welcomeRoute,
            onGenerateRoute: Router.generateRoute,
          );
        } else if (value.authorizationStatus == AuthorizationStatus.Ready) {
          return MaterialApp(
            title: title,
            theme: ThemeData(primarySwatch: Colors.grey),
            initialRoute: homeRoute,
            onGenerateRoute: Router.generateRoute,
          );
        } else {
          return Container(
            color: appBarColor,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/flutter_logo.png',
              height: 100,
            ),
          );
        }
      },
      // child: Container(
      //   color: appBarColor,
      //   alignment: Alignment.center,
      //   child: Image.asset(
      //     'assets/flutter_logo.png',
      //     height: 100,
      //   ),
      // ),
    );
  }
}
