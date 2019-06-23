import 'package:flutter/material.dart';
import 'package:vinyl/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HomePage'),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, loginRoute),
              child: Text('Go to LoginPage'),
            ),
          ],
        ),
      ),
    );
  }
}
