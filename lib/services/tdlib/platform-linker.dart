import 'package:flutter/services.dart';

const _platform = const MethodChannel('tdjsonlib');

Future<int> create() async => await _platform.invokeMethod('create');

Future<void> send(String request) async => await _platform.invokeMethod('send', request);

Future<String> receive(int delay) async => await _platform.invokeMethod('receive', delay);

Future<String> execute(String request) async => await _platform.invokeMethod('execute', request);

Future<void> destroy() async => await _platform.invokeMethod('destroy');
