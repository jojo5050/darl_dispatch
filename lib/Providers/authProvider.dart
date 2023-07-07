

import 'package:darl_dispatch/Models/user.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  User _user = User();
  String? _token;

  //GETTERS
  String? get token => _token;
  User get user => _user;

  //SETTERS
  set token(String? info) {
    _token = info;
    notifyListeners();
  }

  set user(dynamic info) {
    if (info != null) {
      _user = User.fromJson(info);
      notifyListeners();
    } else {
      _user = User();
      notifyListeners();
    }
  }



}