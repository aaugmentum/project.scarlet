import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

int _random() => Random().nextInt(10000000);

abstract class TdObject {
}

abstract class TdFunction extends TdObject {
  String type;
  num extra;
  TdFunction(this.type) {
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
  int x;

  TestSquareInt({@required this.x}) : super('testSquareInt');

  Map<String, dynamic> toJson() {
    var result = super.toJson();
    result['x'] = x;
    return result;
  }

  @override
  String toJsonString() => jsonEncode(this.toJson());
}