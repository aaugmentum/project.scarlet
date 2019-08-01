import 'package:flutter/material.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/routes.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  final TdService _service = TdService();

  @override
  Widget build(BuildContext context) {
    return Provider<TdService>(
      builder: (BuildContext context) {
        _service.create();
        return _service;
      },
      child: MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: splashRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
