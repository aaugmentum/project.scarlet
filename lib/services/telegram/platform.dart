import 'package:flutter/services.dart';

class TdLibJSON {
  static const _platform = const MethodChannel('tdjsonlib');

  static Future<void> create() async => await _platform.invokeMethod('create');

  static Future<void> send({String request}) async => await _platform.invokeMethod('send', <String, dynamic>{'request': request});

  static Future<String> receive({double delay}) async => await _platform.invokeMethod('receive',  <String, dynamic>{'delay': delay});

  static Future<String> execute({String request}) async => await _platform.invokeMethod('execute', <String, dynamic>{'request': request});

  static Future<void> destroy() async => await _platform.invokeMethod('destroy');
}
