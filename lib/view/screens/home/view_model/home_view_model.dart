import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:sezinsoft_demo/view/screens/home/model/user_model.dart';
import 'package:sezinsoft_demo/view/screens/home/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/locator.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/base/viewmodel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final BuildContext context;

  final Api? _Api = locator<Api>();

  HomeViewModel(this.context);

  User? _user;
  User? get user => _user;

  String? _token;
  String? get token => _token;

  setToken(String val) {
    _token = val;
    notifyListeners();
  }

  setUser(User val) {
    _user = val;
    notifyListeners();
  }

  Future getUser({
    required String token,
  }) async {
    setBusy(true);
    final response = await _Api!.getUser(token);
    if (kDebugMode) print("login response $response");
    if (response == null) {
      setErrorMessage('Error has occured with the getuser');
      showDialog(
          context: context,
          builder: (builder) => const AlertDialog(
                title: Text("ERROR"),
                content: Text("Error has occured with the getuser"),
              ));
    } else {
      User user = User.fromJson(response);
      setUser(user);
    }
    setBusy(false);
  }
}
