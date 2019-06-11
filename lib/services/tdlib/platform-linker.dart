import 'package:flutter/services.dart';

const _platform = const MethodChannel('tdjsonlib');

Future<int> create() async => await _platform.invokeMethod('create');

Future<void> send({int client, String request}) async => await _platform.invokeMethod('send', {'client': client, 'request': request});

Future<String> receive({int client, int delay}) async => await _platform.invokeMethod('receive',  {'client': client, 'delay': delay});

Future<String> execute({int client, String request}) async => await _platform.invokeMethod('execute', {'client': client, 'request': request});

Future<void> destroy({int client}) async => await _platform.invokeMethod('destroy',  <String, dynamic>{'client': client});
