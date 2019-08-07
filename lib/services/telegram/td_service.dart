import 'dart:async';
import 'dart:convert';
import 'package:vinyl/services/telegram/platform.dart';
import 'package:vinyl/services/telegram/td_api.dart';

TdService _service = null;

class TdService {
  const TdService();

  void create() async {
    await TdLibJSON.create();
  }

  Future<Result<T>> send<T>(TdFunction function) async {
    String response = function.toString();
    print('Response: $response');
    await TdLibJSON.send(request: response);
    

    while (true) {
      final temp = await TdLibJSON.receive(delay: 1.0);
      if (temp == null) 
        break;
      var responseMap = jsonDecode(temp);
      
      if (responseMap['@extra'] != null && responseMap['@extra'] == function.extra) {
        print('Result: ${responseMap.toString()}');    
        return Result.success(responseMap);
      }
    }
    return Result.error('No Response');
  }

   Future<void> execute<T>(TdFunction function) async {
    String response = function.toString();
    print('Response: $response');
    String result = await TdLibJSON.execute(request: response);
    print('Result: $result');
  }

  factory TdService.getService() => _service == null ? TdService() : _service; 

}

class Result<T> {
  T data;
  String error;

  Result.error(this.error);
  Result.success(this.data);

  get hasError => error != null;
}