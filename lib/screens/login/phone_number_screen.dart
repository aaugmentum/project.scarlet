import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/utils/constants.dart';

class PhoneNumberScreen extends StatefulWidget {
  PhoneNumberScreen({Key key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = TextEditingController();
  }

  Future<void> _check(TdService service) async {
    Result result = await service.send(GetAuthorizationState());
    print("THE RESULT IS ${result.data.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    print('Phone number screen');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    'Please enter your phone number, so we can connect to your telegram account and steal all your data'),
                TextFormField(
                  controller: _controller,
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
                    print("+${_controller.text}");
                    TdService service = Provider.of<TdService>(context);
                    var result = await service.send(
                        SetAuthenticationPhoneNumber(
                            phoneNumber: "+${_controller.text}"));
                    if (result.data["@type"] == 'ok') {
                      Navigator.pushNamed(context, codeRoute);
                    }
                  },
                  child: Text('Enter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
