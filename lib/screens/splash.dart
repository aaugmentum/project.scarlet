import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/styles.dart';
import 'package:vinyl/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TdService _service;

  Future<void> _initialize() async {
    await _service.execute(SetLogVerbosityLevel(newVerbosityLevel: 1));

    Directory tempDirectory = await getTemporaryDirectory();
    String dbPath = tempDirectory.path;

    await _service.send(SetTdlibParameters(
        parameters: TdlibParameters(
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

    await _service
        .send(CheckDatabaseEncryptionKey(encryptionKey: "ragepanda"));
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_service == null) {
      this._service = Provider.of<TdService>(context);
      await _initialize();
      Future.delayed(Duration(seconds: 1),
          () => Navigator.of(context).popAndPushNamed(welcomeRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/flutter_logo.png',
        height: 100,
      ),
    );
  }
}
