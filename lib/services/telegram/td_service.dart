import 'dart:async';
import 'dart:convert';
import 'package:vinyl/services/telegram/platform.dart';
import 'package:vinyl/services/telegram/td_api.dart';

class TdService {

  const TdService();

  void create() async {
    await TdLibJSON.create();
  }

  Future<Result<T>> send<T>(TdFunction function) async {
    await TdLibJSON.send(request: function.toString());

    while (true) {
      final temp = await TdLibJSON.receive(delay: 1.0);
      if (temp == null) 
        continue;
      var responseMap = jsonDecode(temp);
      
      if (responseMap['@extra'] != null && responseMap['@extra'] == function.extra) 
        return Result.success(responseMap);
    }
  }
}

class Result<T> {
  T data;
  String error;

  Result.error(this.error);
  Result.success(this.data);

  get hasError => error != null;
}