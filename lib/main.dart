import 'package:flutter/material.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/routes.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: homeRoute,
      onGenerateRoute: Router.generateRoute,
    );
  }
}