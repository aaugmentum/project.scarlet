import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('LoginPage'),
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go to HomePage'),
            ),
          ],
        ),
      ),
    );
  }
}
