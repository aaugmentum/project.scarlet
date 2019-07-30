import 'package:flutter/material.dart';
import 'package:vinyl/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: "Welcome to project.scarlet",
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              fillColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              constraints: BoxConstraints(minHeight: 50, minWidth: 150),
              onPressed: () {
                Navigator.pushNamed(context, phoneNumberRoute);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
