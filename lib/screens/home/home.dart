import 'package:flutter/material.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = TdService(delay: 2.0);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HomePage'),
            RaisedButton(
              onPressed: () async {
                print('Clicked');
                service.create();
                Result result = await service.send(TestSquareInt(x: 5));
                print(result.hasError ? result.error : result.data);
              },
              child: Text('Square'),
            ),
          ],
        ),
      ),
    );
  }
}
