import 'dart:async';
import 'dart:convert';
import 'package:vinyl/services/telegram/platform.dart';
import 'package:vinyl/services/telegram/td_api.dart';

class TdService {
  double _delay; 
  bool _isCreated;

  final StreamController<String> _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream.where((data) => data != null);


  TdService({delay = 5.0}) {
    this._delay = delay; 
    this._isCreated = false;
  }

  void create() async {
    if (_isCreated) return;
    await TdLibJSON.create();
    _isCreated = true;
    _start();
  }

  void _start() {
    Timer.periodic(Duration(seconds: _delay.floor()), (t) async {
      _controller.sink.add(await TdLibJSON.receive(delay: _delay));
    });
  }

  void destroy() async {
    if (!_isCreated) return;
    await TdLibJSON.destroy();
    _controller.close();
    _isCreated = false;
  }

  Future<Result<T>> send<T>(TdFunction function) async {
    bool isEqual(json) => json['@extra'] != null && json['@extra'] == function.extra;

    await TdLibJSON.send(request: function.toString());

    // while (_isCreated) {
    //   var responseMap = jsonDecode(await TdLibJSON.receive(delay: _delay));
      
    //   if (responseMap['@extra'] != null && responseMap['@extra'] == function.extra) 
    //     return Result.success(responseMap);
    // }
    // return Result.error('Client is destroyed');

    final result = await stream.map((data) => jsonDecode(data))
                                                .where(isEqual)
                                                .first;
    return Result.success(result);
  }
}

class Result<T> {
  T data;
  String error;

  Result.error(this.error);
  Result.success(this.data);

  get hasError => error != null;
}