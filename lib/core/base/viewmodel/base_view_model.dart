import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  String? _errorMessage;
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  bool get busy => _busy;
  String? get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != null && _errorMessage!.isNotEmpty;

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void setLogin(bool value) {
    _loggedIn = value;
    notifyListeners();
  }
}
