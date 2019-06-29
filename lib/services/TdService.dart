import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:vinyl/services/platform/tdlibjson.dart';

class TdFunction {
  TdObject data;
  Function callback;
  TdFunction(this.data, this.callback);
}

abstract class TdObject {
  final String type;
  final int extra;
  final int id;

  TdObject(this.type, this.extra, this.id);

  Map<String, dynamic> toJson() => 
    {
      '@type': this.type,
      '@extra': this.extra
    };

  static int random() => Random().nextInt(1000000);
}

class TdTestSquare extends TdObject {
  final int x;
  static const int CONSTRUCTOR = -111;

  TdTestSquare({this.x}) : super('testSquareInt', TdObject.random(), CONSTRUCTOR);

  Map<String, dynamic> toJson() {
    var result = super.toJson();
    result['x'] = x;
    return result;
  }

  String toJsonString() => jsonEncode(toJson());
}


class TdService {
  Queue<TdFunction> _callbackQueue;
  double _delay; 
  bool _isCreated;

  TdService() {
    _callbackQueue = Queue();
    _delay = 5.0;
    _isCreated = false;
  }

  void create() async {
    if (_isCreated) return;
    await TdLibJSON.create();
    _isCreated = true;
    _receive();
  }

  void destroy() async {
    if (!_isCreated) return;
    await TdLibJSON.destroy();
    _isCreated = false;
  }

  void send(TdObject data, Function callback) async {
    var func = TdFunction(data, callback);
    _callbackQueue.add(func);    

    switch (data.id) {
      case TdTestSquare.CONSTRUCTOR:
        await TdLibJSON.send(request: (data as TdTestSquare).toJsonString());
        break;
      default:
    }
  }

  void _receive() async {
    await for(var response in _receiveStream()) {
      if(response == null) continue; 
      var responseMap = jsonDecode(response);
      var extra = responseMap['@extra'];
      if(extra == null) continue; 
      
      if (extra == _callbackQueue.first.data.extra) {
        _callbackQueue.first.callback(responseMap);
        _callbackQueue.removeFirst();
      }
    }
  }

  Stream<String> _receiveStream() async* {
    while(true) 
      yield await TdLibJSON.receive(delay: _delay);
  }
}