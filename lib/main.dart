import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vinyl/services/telegram/platform.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/utils/constants.dart' as prefix0;
import 'package:vinyl/utils/routes.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';
import 'package:path_provider/path_provider.dart';


void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  final service = TdService(delay: 1.0);
  
  Future<bool> initialize() async {
    service.create();
    service.stream.listen(print);
    Directory dbDirectory = await getTemporaryDirectory();
    String dbPath = dbDirectory.path;
    await service.send(SetTdlibParameters(parameters: new TdlibParameters(
      databaseDirectory: dbPath, 
      useMessageDatabase: true, 
      useSecretChats: false,
      apiId: 563135,
      apiHash: "85021a6322d640fd509cbae5bebcf4e6",
      systemLanguageCode: "en",
      deviceModel: "Desktop",
      systemVersion: "Unknown",
      applicationVersion: "1.0",
      enableStorageOptimizer: true
    )));
    
   await service.send(CheckDatabaseEncryptionKey(encryptionKey: "ragepanda"));
   return true;
  }
  @override
  Widget build(BuildContext context) {

    Future<Map<String,dynamic>> getAuthState() async{
      Map<String, dynamic> authState;
      // initialize().whenComplete(()async=>{
      //   service.send(GetAuthorizationState()).then((response) => {
      //      authState = response.data,
      //      print('the result is ${authState["@type"]}')
      //   })
      // });
      await initialize();
      await service.send(GetAuthorizationState()).then((response) => authState = response.data);
      return authState;
    }
    // return FutureBuilder(
    //   future: getAuthState(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot){
    //     print(snapshot.data['@type']);
    //     if(snapshot.data != null){
    //       if(snapshot.data['@type'] == "authorizationStateWaitPhoneNumber"){
    //         return MaterialApp(
    //           title: title,
    //           theme: ThemeData(primarySwatch: Colors.blue),
    //           initialRoute: welcomeRoute,
    //           onGenerateRoute: Router.generateRoute,
    //         );
    //       }
    //     }else{
    //       return Container(
    //       color: Colors.red,
    //       );
    //     }
    //   },
    // );

    return MaterialApp(
              title: title,
              theme: ThemeData(primarySwatch: Colors.blue),
              initialRoute: welcomeRoute,
              onGenerateRoute: Router.generateRoute,
            );
  }
}
