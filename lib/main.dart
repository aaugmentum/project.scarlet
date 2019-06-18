import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
  var _items = <String>[];

  void _createClient() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    var request = {
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

    await TdLibJSON.create();
    await TdLibJSON.send(request: jsonEncode(request));

    request = {'@type': 'checkDatabaseEncryptionKey', 'key': 'pinkPony'};
    await TdLibJSON.send(request: jsonEncode(request));

    await for (var item in _logger()) {
      if (item == null) continue;
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      item = encoder.convert(jsonDecode(item));

      _items.insert(0, item);
      setState(() {
        _items = _items;
      });
    }
  }

  Stream<String> _logger() async* {
    while (true) {
      yield await TdLibJSON.receive(delay: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(flex: 3, child: ReceiveLog(_items)),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: _createClient,
                  child: Text("Start"),
                ),
              ],
            ),
          ),
        ],
    )));
  }
}

class ReceiveLog extends StatelessWidget {
  const ReceiveLog(this._items, {Key key}) : super(key: key);
  final _items;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, i) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_items[i], style: TextStyle(fontSize: 14), softWrap: true,),
            ),
          );
        },
      ),
    );
  }
}
