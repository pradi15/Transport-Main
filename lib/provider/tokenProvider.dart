// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:transport/Service/saveToLocal.dart';
import 'package:transport/utils/constant.dart';

class AuthToken extends ChangeNotifier {
  String _token = '';
  String get token {
    return _token;
  }

  void setToken({String? token, String? who}) {
    print('==Token=====$token==============');
    print('==Who This=====$who================');
    SaveToLocal.setAsString(key: Strings.token, value: token);
    SaveToLocal.setAsString(key: Strings.who, value: who);
    _token = token!;
    notifyListeners();
  }

  void destroyToken() async {
    SaveToLocal.clear(key: Strings.token);
    SaveToLocal.clear(key: Strings.who);
    _token = '';
    notifyListeners();
  }
}
