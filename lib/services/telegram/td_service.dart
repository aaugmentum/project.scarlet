import 'dart:collection';
import 'dart:convert';
import 'package:vinyl/services/telegram/platform.dart';
import 'package:vinyl/services/telegram/td_api.dart';

class TdService {
  Queue<TdFunction> _callbackQueue;
  double _delay; 
  bool _isCreated;

  TdService([delay = 5.0]) {
    this._callbackQueue = Queue();
    this._delay = delay; 
    this._isCreated = false;
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

  void send(TdFunction function) async {
    _callbackQueue.addLast(function);    

    await TdLibJSON.send(request: function.toJsonString());
  }

  void _receive() async {
    await for(var response in _receiveStream()) {
      if(response == null) continue; 
      var responseMap = jsonDecode(response);
      var extra = responseMap['@extra'];
      if(extra == null && _callbackQueue.isEmpty) continue; 
      
      if (extra == _callbackQueue.first.extra) {
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