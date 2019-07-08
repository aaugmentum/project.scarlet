import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vinyl/components/login_widged.dart';
import 'package:vinyl/components/search_widged.dart';
import 'package:vinyl/components/music_card.dart';
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
  // var _items = <String>[];
  var _items = <Map<String, dynamic>>[];
  bool isPlaying = false;

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
      Map itemMap = jsonDecode(item);
      if(itemMap['@type'] == "messages"){
        _items.insert(0, itemMap);
      }
      if(itemMap['@type'] == "file"){
        // var percent = itemMap['local']['downloaded_size']/itemMap['size'] * 100.0;
      }
      setState(() {
        _items = _items;
      });
    }
  }

  Stream<String> _logger() async* {
    while (true) {
      yield await TdLibJSON.receive(delay: 1);
      // await Future.delayed(Duration(seconds: 2));
    }
  }

  void _getFile() async {
    var request = {
      "@type": "downloadFile",
      "priority": 1,
      "file_id": 195,
      "offset": 0,
      "limit": 7256355,
      "synchronous": true
    };

    var string = jsonEncode(request);
    print(string);

    await TdLibJSON.send(request: string);
  }

  void _playMusic() async {
    if(!isPlaying){
      MusicChannel.play();
      isPlaying = true;
    }else{
      MusicChannel.pause();
      isPlaying = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(flex: 2, child: ReceiveLogger(_items)),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 3),
                  RaisedButton(
                    onPressed: _createClient,
                    child: Text("Start"),
                  ),
                  // SizedBox(width: 25),
                  RaisedButton(
                    onPressed: _getFile,
                    child: Text("File"),
                  ),
                  // SizedBox(width: 25),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                      //  _items = <String>[]; 
                       _items = <Map<String, dynamic>>[]; 
                      });
                    },
                    child: Text("Clear Log"),
                  ),
                  // SizedBox(width: 25),
                  RaisedButton(
                    onPressed: _playMusic,
                    child: Text("Play"),
                  ),
                ],
              ),
              // Login Form
              LoginForm(),
              SearchForm()
            ],
          ),
        ),
      ],
    )));
  }
}

class ReceiveLogger extends StatelessWidget {
  const ReceiveLogger(this._items, {Key key}) : super(key: key);
  final _items;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      child: ListView.builder(
        itemCount: _items.length == 0?0:_items[0]['messages'].length,
        itemBuilder: (context, i) {
          // return Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Text(_items[i], style: TextStyle(fontSize: 14), softWrap: true,),
          //   ),
          // );
          return MusicCard(title: _items[0]['messages'][i]['content']['audio']['title'], id: _items[0]['messages'][i]['content']['audio']['audio']['id'], size: _items[0]['messages'][i]['content']['audio']['audio']['size'], fileName: _items[0]['messages'][i]['content']['audio']['file_name']);
        },
      ),
    );
  }
}
