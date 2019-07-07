// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSquareInt _$TestSquareIntFromJson(Map<String, dynamic> json) {
  return TestSquareInt(x: json['x'] as int)
    ..type = json['@type'] as String
    ..extra = json['@extra'] as num;
}

Map<String, dynamic> _$TestSquareIntToJson(TestSquareInt instance) =>
    <String, dynamic>{
      '@type': instance.type,
      '@extra': instance.extra,
      'x': instance.x
    };

SetLogStream _$SetLogStreamFromJson(Map<String, dynamic> json) {
  return SetLogStream(logStream: json['log_stream'] as int)
    ..type = json['@type'] as String
    ..extra = json['@extra'] as num;
}

Map<String, dynamic> _$SetLogStreamToJson(SetLogStream instance) =>
    <String, dynamic>{
      '@type': instance.type,
      '@extra': instance.extra,
      'log_stream': instance.logStream
    };

SetTdlibParameters _$SetTdlibParametersFromJson(Map<String, dynamic> json) {
  return SetTdlibParameters(
      parameters: json['parameters'] == null
          ? null
          : TdlibParameters.fromJson(
              json['parameters'] as Map<String, dynamic>))
    ..type = json['@type'] as String
    ..extra = json['@extra'] as num;
}

Map<String, dynamic> _$SetTdlibParametersToJson(SetTdlibParameters instance) =>
    <String, dynamic>{
      '@type': instance.type,
      '@extra': instance.extra,
      'parameters': instance.parameters
    };

TdlibParameters _$TdlibParametersFromJson(Map<String, dynamic> json) {
  return TdlibParameters(
      useTestDc: json['use_test_dc'] as bool,
      databaseDirectory: json['database_directory'] as String,
      filesDirectory: json['files_directory'] as String,
      useFileDatabase: json['use_file_database'] as bool,
      useChatInfoDatabase: json['use_chat_info_database'] as bool,
      useMessageDatabase: json['use_message_database'] as bool,
      useSecretChats: json['use_secret_chats'] as bool,
      apiId: json['api_id'] as String,
      apiHash: json['api_hash'] as String,
      systemLanguageCode: json['system_language_code'] as String,
      deviceModel: json['device_model'] as String,
      systemVersion: json['system_version'] as String,
      applicationVersion: json['application_version'] as String,
      enableStorageOptimizer: json['enable_storage_optimizer'] as bool,
      ignoreFileNames: json['ignore_file_names'] as bool);
}

Map<String, dynamic> _$TdlibParametersToJson(TdlibParameters instance) =>
    <String, dynamic>{
      'use_test_dc': instance.useTestDc,
      'database_directory': instance.databaseDirectory,
      'files_directory': instance.filesDirectory,
      'use_file_database': instance.useFileDatabase,
      'use_chat_info_database': instance.useChatInfoDatabase,
      'use_message_database': instance.useMessageDatabase,
      'use_secret_chats': instance.useSecretChats,
      'api_id': instance.apiId,
      'api_hash': instance.apiHash,
      'system_language_code': instance.systemLanguageCode,
      'device_model': instance.deviceModel,
      'system_version': instance.systemVersion,
      'application_version': instance.applicationVersion,
      'enable_storage_optimizer': instance.enableStorageOptimizer,
      'ignore_file_names': instance.ignoreFileNames
    };
