import 'package:flutter/material.dart';
import 'package:vinyl/models/global.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Global()..init(),
        ),
        Provider.value(
          value: _service..create(),
        )
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.grey),
        initialRoute: splashRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
