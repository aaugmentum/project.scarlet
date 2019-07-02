import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

int _random() => Random().nextInt(10000000);

abstract class TdObject {
  int getConstructor();
}

abstract class TdFunction extends TdObject {
  String type;
  num extra;
  Function callback;
  TdFunction(this.type, this.callback) {
    this.extra = _random();
  }

  Map<String, dynamic> toJson() => 
    {
      '@type': this.type,
      '@extra': this.extra
    };
  
  String toJsonString();
}

class TestSquareInt extends TdFunction {
  static const int CONSTUCTOR = 1000;
  int x;

  TestSquareInt({@required this.x, @required callback}) : super('testSquareInt', callback);

  @override
  int getConstructor() {
    return CONSTUCTOR;
  }

  Map<String, dynamic> toJson() {
    var result = super.toJson();
    result['x'] = x;
    return result;
  }

  @override
  String toJsonString() => jsonEncode(this.toJson());
}