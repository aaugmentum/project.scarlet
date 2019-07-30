import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/routes.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  final TdService _service = TdService();

  Future<bool> _initialize() async {
    Directory dbDirectory = await getTemporaryDirectory();
    String dbPath = dbDirectory.path;
    Result result = await _service.send(SetTdlibParameters(
        parameters: new TdlibParameters(
            databaseDirectory: dbPath,
            useMessageDatabase: true,
            useSecretChats: false,
            apiId: 563135,
            apiHash: "85021a6322d640fd509cbae5bebcf4e6",
            systemLanguageCode: "en",
            deviceModel: "Desktop",
            systemVersion: "Unknown",
            applicationVersion: "1.0",
            enableStorageOptimizer: true)));

    print(result.data);
    result = await _service
        .send(CheckDatabaseEncryptionKey(encryptionKey: "ragepanda"));

    print(result.data);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Provider<TdService>(
      builder: (BuildContext context) {
        _service.create();
        _initialize();
        return _service;
      },
      child: MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: welcomeRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
