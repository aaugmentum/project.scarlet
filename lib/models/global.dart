import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vinyl/services/telegram/td_api.dart';
import 'package:vinyl/services/telegram/td_service.dart';

enum AuthorizationStatus { WaitTdLibParameters, WaitPhoneNumber, WaitCode }

class Global with ChangeNotifier {
  final TdService _service = TdService.getService();
  AuthorizationStatus _authorizationStatus;

  Global() {
    _service.create();
  }

  Future<void> init() async {
    await _service.execute(SetLogVerbosityLevel(newVerbosityLevel: 1));

    Directory tempDirectory = await getTemporaryDirectory();
    String dbPath = tempDirectory.path;

    await _service.send(
      SetTdlibParameters(
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
            enableStorageOptimizer: true),
      ),
    );

    await _service.send(CheckDatabaseEncryptionKey(encryptionKey: "ragepanda"));

    Result<Map<String, dynamic>> result = await _service.send(GetAuthorizationState());
    authorizationStatus = result.data['@type'];

  }  

  get authorizationStatus => _authorizationStatus; 
  set authorizationStatus(String state) {
    print(state);
    switch (state) {
      case 'authorizationStateWaitPhoneNumber':
        _authorizationStatus = AuthorizationStatus.WaitPhoneNumber;
        break;
      default:
    }
    notifyListeners();
  }
}
