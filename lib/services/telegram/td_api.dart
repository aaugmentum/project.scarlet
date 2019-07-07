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
  String apiId;
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