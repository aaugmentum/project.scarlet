import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/constants.dart' as prefix0;
import 'package:vinyl/utils/routes.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key key}) : super(key: key);

  void check(TdService service) async {
    Result result = await service.send(GetAuthorizationState());
    print("THE RESULT IS ${result.data.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<TdService>(context);
    var controller = TextEditingController();
    check(service);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Please enter your phone number, so we can connect to your telegram account and steal all your data'),
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: 'Enter your phone number'),
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
                  service.send(SetAuthenticationPhoneNumber(
                      phoneNumber: "+${controller.text}"));
                  Navigator.pushNamed(context, codeRoute);
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
