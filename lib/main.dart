import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vinyl/services/tdlib/platform-linker.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel('tdjsonlib');
  String _client = 'Press button';
  final TextEditingController controller = TextEditingController();

  void _createClient() async {
    await TdLibJSON.create();
  }

  Stream<String> receive() async* {
    while (true) {
      yield await TdLibJSON.receive(delay: 5);
    }
  }

  void setParams() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    var setParams = {
      '@type': 'setTdlibParameters',
      'parameters': {
        'database_directory': tempPath,
        'use_message_database': true,
        'use_secret_chats': true,
        'api_id': 94575,
        'api_hash': 'a3406de8d171bb422bb6ddf3bbd800e2',
        'system_language_code': 'en',
        'device_model': 'Desktop',
        'system_version': 'Unknown',
        'application_version': '1.0',
        'enable_storage_optimizer': true
      }
    };

    await TdLibJSON.send(request: jsonEncode(setParams));
  }

  void setKey() async {
    var setKey = {'@type': 'checkDatabaseEncryptionKey', 'key': 'cucumber'};
    await TdLibJSON.send(request: jsonEncode(setKey));
  }

  void sendNumber() async {
    var number = controller.text;
    var sendNumber = {
      '@type': 'setAuthenticationPhoneNumber',
      'phone_number': '+' + number
    };

    await TdLibJSON.send(request: jsonEncode(sendNumber));
  }

  void sendCode() async {
    var sendCode = {
      "@type": "checkAuthenticationCode",
      "code": controller.text
    };

    await TdLibJSON.send(request: jsonEncode(sendCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FractionallySizedBox(
            heightFactor: .5,
            alignment: Alignment.topCenter,
            child: TdlibReceiveLogList(),
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _createClient,
                child: Text('Create'),
              )
            ],
          )
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(
      //           'Result: $_client',
      //           style: TextStyle(fontSize: 20),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //       Row(
      //         children: <Widget>[
      //           RaisedButton(
      //             child: Text('GetState'),
      //             onPressed: () async {
      //               var state = {
      //                 '@type': 'checkDatabaseEncryptionKey',
      //                 'key': 'cucumber'
      //               };
      //               await TdLibJSON.send(request: jsonEncode(state));
      //               var result = await TdLibJSON.receive(delay: 1);
      //               setState(() {
      //                 _client = result;
      //               });
      //             },
      //           ),
      //           RaisedButton(
      //             child: Text('GetClient'),
      //             onPressed: create,
      //           ),
      //           RaisedButton(
      //             child: Text('SetParams'),
      //             onPressed: setParams,
      //           ),
      //           RaisedButton(
      //             child: Text('SetKey'),
      //             onPressed: setKey,
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: <Widget>[
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 20),
      //             width: 200,
      //             child: TextField(
      //               controller: controller,
      //               decoration:
      //                   new InputDecoration(labelText: 'Enter your number'),
      //               keyboardType: TextInputType.number,
      //             ),
      //           ),
      //           RaisedButton(
      //             child: Text('SendNumber'),
      //             onPressed: sendNumber,
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: <Widget>[
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 20),
      //             width: 200,
      //             child: TextField(
      //               controller: controller,
      //               decoration:
      //                   new InputDecoration(labelText: 'Enter your code'),
      //               keyboardType: TextInputType.number,
      //             ),
      //           ),
      //           RaisedButton(
      //             child: Text('SendCode'),
      //             onPressed: sendCode,
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class TdlibReceiveLogList extends StatelessWidget {
  const TdlibReceiveLogList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
