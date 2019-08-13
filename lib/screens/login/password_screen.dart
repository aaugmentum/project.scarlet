import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/routes.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Code Screen build');

    var controller = TextEditingController();

    final service = Provider.of<TdService>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Looks like you have two step authentication bastard. Enter the password NOW.'),
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Entered a wrong number?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RawMaterialButton(
                fillColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                textStyle: TextStyle(color: Colors.white, fontSize: 18),
                constraints: BoxConstraints(minHeight: 40, minWidth: 100),
                onPressed: () async {
                  service.send(CheckAuthenticationPassword(password: controller.text));
                  Navigator.pushNamed(context, homeRoute);
                },
                child: Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
