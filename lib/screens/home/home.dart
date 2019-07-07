import 'package:flutter/material.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = TdService(delay: 2.0);
    service.create();
    service.stream.listen(print);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HomePage'),
            RaisedButton(
              onPressed: () async {
                print('Clicked');
                await service.send(TestSquareInt(x: 5));

              },
              child: Text('Square'),
            ),
          ],
        ),
      ),
    );
  }
}
