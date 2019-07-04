import 'dart:convert';
import 'package:vinyl/services/telegram/platform.dart';
import 'package:vinyl/services/telegram/td_api.dart';

class TdService {
  double _delay; 
  bool _isCreated;

  TdService({delay = 5.0}) {
    this._delay = delay; 
    this._isCreated = false;
  }

  void create() async {
    if (_isCreated) return;
    await TdLibJSON.create();
    _isCreated = true;
  }

  void destroy() async {
    if (!_isCreated) return;
    await TdLibJSON.destroy();
    _isCreated = false;
  }

  Future<Result<T>> send<T>(TdFunction function) async {
    await TdLibJSON.send(request: function.toJsonString());

    while (_isCreated) {
      var responseMap = jsonDecode(await TdLibJSON.receive(delay: _delay));
      
      if (responseMap['@extra'] != null && responseMap['@extra'] == function.extra) 
        return Result.success(responseMap);
    }
    return Result.error('Client is destroyed');
  }
}

class Result<T> {
  T data;
  String error;

  Result.error(this.error);
  Result.success(this.data);

  get hasError => error != null;
}