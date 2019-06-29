import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/services/tdlib/platform-linker.dart';

enum _States { WaitNumber, WaitCode, Finished }

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _state = _States.WaitNumber;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _state != _States.Finished,
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 250,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    labelText:
                        'Enter ${_state == _States.WaitNumber ? 'your phone number:' : 'code:'}'),
              ),
            ),
            RaisedButton(
                child: Text('Send'),
                onPressed: _state == _States.WaitNumber
                    ? () async {
                        var request = {
                          "@type": "setAuthenticationPhoneNumber",
                          "phone_number": _controller.text
                        };

                        await TdLibJSON.send(request: jsonEncode(request));

                        setState(() {
                          _state = _States.WaitCode;
                          _controller.text = '';
                        });
                      }
                    : () async {
                        var request = {
                          "@type": "checkAuthenticationCode",
                          "code": _controller.text
                        };

                        await TdLibJSON.send(request: jsonEncode(request));

                        setState(() {
                          _state = _States.Finished;
                        });
                      })
          ],
        ),
      ),
    );
  }
}
