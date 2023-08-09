import 'package:flutter/material.dart';
import 'package:todo_app/core/locale/local_constant.dart';

class LoginScreenNotifier extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String errorInfo = '';
  String _usernameError = '';
  String _passwordError = '';

  void onUserInPutChange(String value) async {
    _usernameError = '';
    notifyListeners();
  }

  void onPasswordInputChange(String value) {
    _passwordError = '';
    notifyListeners();
  }

  void onUsernameSubmitted(String value) {
    if (value.length < 7) {
      _usernameError = LocalStrings.invalidUserName;
    } else if (value.length > 15) {
      _usernameError = LocalStrings.invalidUserName;
    } else {
      _usernameError = '';
    }
    notifyListeners();
  }

  void onPasswordSubmitted(String value) {
    if (value.length < 8) {
      _passwordError = LocalStrings.invalidPassword;
    } else if (value.contains(' ')) {
      _passwordError = LocalStrings.invalidPassword;
    } else {
      _passwordError = '';
    }
    notifyListeners();
  }

  String get usernameError => _usernameError;
  String get passwordError => _passwordError;
}
