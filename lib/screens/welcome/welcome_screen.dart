import 'package:flutter/material.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'dart:io';
import 'package:provider/provider.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  Future<bool> initialize(TdService service) async {
    Directory dbDirectory = await getTemporaryDirectory();
    String dbPath = dbDirectory.path;
    Result result = await service.send(SetTdlibParameters(
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
    result = await service.send(CheckDatabaseEncryptionKey(encryptionKey: "ragepanda"));
    print(result.data);


    return true;
  }

  @override
  Widget build(BuildContext context) {
    final TdService service = Provider.of<TdService>(context);
    service.create();

    Future.delayed(Duration(seconds: 2), () => initialize(service));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: "Welcome to project.scarlet",
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              fillColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              constraints: BoxConstraints(minHeight: 50, minWidth: 150),
              onPressed: () {
                Navigator.pushNamed(context, phoneNumberRoute);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
