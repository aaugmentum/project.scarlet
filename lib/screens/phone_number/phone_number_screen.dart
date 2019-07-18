import 'package:flutter/material.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/constants.dart' as prefix0;
import 'package:vinyl/utils/routes.dart';
class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final service = TdService(delay: 1.0);  
  var controller = TextEditingController();

  service.create();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text('Please enter your phone number, so we can connect to your telegram account and steal all your data'),
             TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
               decoration: InputDecoration(
                 labelText: 'Enter your phone number'
                ),
             ),
            SizedBox(height: 10,),
            RawMaterialButton(
              fillColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), 
                textStyle: TextStyle(color: Colors.white, fontSize: 18),
                constraints: BoxConstraints(minHeight: 40, minWidth: 100),
                onPressed: () async {
                  print("+${controller.text}");
                  service.send(SetAuthenticationPhoneNumber(
                    phoneNumber: "+${controller.text}"
                  ));
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
