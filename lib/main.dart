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
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _client = 'Press button';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vinyl')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Client created from tdlibjson: $_client', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
            ),
            RaisedButton(
              child: Text('GetClient'),
              onPressed: () async {
                int client = await create();

                await destroy(client: client);

                setState(() {
                 _client = client.toString(); 
                });
              },
            )
          ],
        ),
      ), 
    );
  }
}