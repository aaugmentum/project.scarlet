import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'td_api.g.dart';

int _random() => Random().nextInt(10000000);

abstract class TdObject {
  Map<String, dynamic> toJson();
  @override
  String toString() => jsonEncode(toJson());
}

abstract class TdFunction extends TdObject {
  TdFunction(this.type) {
    this.extra = _random();
  }

  @JsonKey(name: '@type')
  String type;
  @JsonKey(name: '@extra')
  num extra;
}

@JsonSerializable()
class TestSquareInt extends TdFunction {
  TestSquareInt({@required this.x}) : super('testSquareInt');

  int x;

  factory TestSquareInt.fromJson(Map<String, dynamic> json) => _$TestSquareIntFromJson(json);  

  @override
  Map<String, dynamic> toJson() => _$TestSquareIntToJson(this);
}

@JsonSerializable()
class SetLogStream extends TdFunction {
  SetLogStream({this.logStream}) : super('setLogStream');

  @JsonKey(name: 'log_stream')
  int logStream;

  factory SetLogStream.fromJson(Map<String, dynamic> json) => _$SetLogStreamFromJson(json);  

  @override
  Map<String, dynamic> toJson() => _$SetLogStreamToJson(this);
}

@JsonSerializable()
class SetTdlibParameters extends TdFunction {
  SetTdlibParameters({this.parameters}) : super('setTdlibParameters');
  
  TdlibParameters parameters;

  factory SetTdlibParameters.fromJson(Map<String, dynamic> json) => _$SetTdlibParametersFromJson(json);  

  @override
  Map<String, dynamic> toJson() => _$SetTdlibParametersToJson(this);
}

@JsonSerializable()
class TdlibParameters extends TdObject {
  TdlibParameters({this.useTestDc, this.databaseDirectory, this.filesDirectory, this.useFileDatabase, this.useChatInfoDatabase, this.useMessageDatabase, this.useSecretChats, this.apiId, this.apiHash, this.systemLanguageCode, this.deviceModel, this.systemVersion, this.applicationVersion, this.enableStorageOptimizer, this.ignoreFileNames});
  
  @JsonKey(name: 'use_test_dc')
  bool useTestDc;
  @JsonKey(name: 'database_directory')  
  String databaseDirectory;
  @JsonKey(name: 'files_directory')
  String filesDirectory;
  @JsonKey(name: 'use_file_database')
  bool useFileDatabase;
  @JsonKey(name: 'use_chat_info_database')
  bool useChatInfoDatabase;
  @JsonKey(name: 'use_message_database')
  bool useMessageDatabase;
  @JsonKey(name: 'use_secret_chats')
  bool useSecretChats;
  @JsonKey(name: 'api_id')
  int apiId;
  @JsonKey(name: 'api_hash')
  String apiHash;
  @JsonKey(name: 'system_language_code')
  String systemLanguageCode;
  @JsonKey(name: 'device_model')
  String deviceModel;
  @JsonKey(name: 'system_version')
  String systemVersion;
  @JsonKey(name: 'application_version')
  String applicationVersion;
  @JsonKey(name: 'enable_storage_optimizer')
  bool enableStorageOptimizer;
  @JsonKey(name: 'ignore_file_names')
  bool ignoreFileNames;

  factory TdlibParameters.fromJson(Map<String, dynamic> json) => _$TdlibParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TdlibParametersToJson(this);
}

@JsonSerializable()
class GetAuthorizationState extends TdFunction {
  GetAuthorizationState() : super('getAuthorizationState');
  
  factory GetAuthorizationState.fromJson(Map<String, dynamic> json) => _$GetAuthorizationStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAuthorizationStateToJson(this);
}

@JsonSerializable()
class CheckDatabaseEncryptionKey extends TdFunction {
  CheckDatabaseEncryptionKey({this.encryptionKey}) : super('checkDatabaseEncryptionKey');

  @JsonKey(name: 'key')
  String encryptionKey;

  factory CheckDatabaseEncryptionKey.fromJson(Map<String, dynamic> json) => _$CheckDatabaseEncryptionKeyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckDatabaseEncryptionKeyToJson(this);
}

@JsonSerializable()
class SetAuthenticationPhoneNumber extends TdFunction {
  SetAuthenticationPhoneNumber({this.phoneNumber, this.allowFlashCall, this.isCurrentPhoneNumber}) : super('setAuthenticationPhoneNumber');

  @JsonKey(name: 'phone_number')
  String phoneNumber;
  @JsonKey(name: 'allow_flash_call')
  bool allowFlashCall;
  @JsonKey(name: 'is_current_phone_number')
  bool isCurrentPhoneNumber;

  factory SetAuthenticationPhoneNumber.fromJson(Map<String, dynamic> json) => _$SetAuthenticationPhoneNumberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SetAuthenticationPhoneNumberToJson(this);
}

@JsonSerializable()
class CheckAuthenticationCode extends TdFunction {
  CheckAuthenticationCode({this.code, this.firstName, this.lastName}) : super('checkAuthenticationCode');

  String code;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;

  factory CheckAuthenticationCode.fromJson(Map<String, dynamic> json) => _$CheckAuthenticationCodeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckAuthenticationCodeToJson(this);
}

@JsonSerializable()
class CheckAuthenticationPassword extends TdFunction {
  CheckAuthenticationPassword({this.password}) : super('checkAuthenticationPassword');

  String password;

  factory CheckAuthenticationPassword.fromJson(Map<String, dynamic> json) => _$CheckAuthenticationPasswordFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckAuthenticationPasswordToJson(this);
}


