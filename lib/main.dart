
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vinyl/services/tdlib/platform-linker.dart';

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

  void create() async {
    await TdLibJSON.create();

    await for (var result in receive()) {
      setState(() {
       _client = result; 
      });
    }
  }

  Stream<String> receive() async* {
    while (true) {
      yield await TdLibJSON.receive(delay: 5);
    }
  }

  void auth() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vinyl')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Result: $_client',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              child: Text('GetClient'),
              onPressed: create,
            ),
            RaisedButton(
              child: Text('Receive'),
              onPressed: receive,
            )
          ],
        ),
      ),
    );
  }
}
