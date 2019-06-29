import 'package:flutter/material.dart';
import 'package:vinyl/services/TdService.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HomePage'),
            RaisedButton(
              onPressed: () async {
                var service = TdService();
                service.create();
                service.send(TdTestSquare(x: 12), (map) {
                  print(map);
                });
              },
              child: Text('Square'),
            ),
          ],
        ),
      ),
    );
  }
}
