import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/utils/constants.dart';

class CodeScreen extends StatelessWidget {
  const CodeScreen({Key key}) : super(key: key);

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
                  'We sent the code to you number. Please enter it to lose everything =)'),
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Code'),
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
                  print("+${controller.text}");
                  service.send(CheckAuthenticationCode(code: controller.text));
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
