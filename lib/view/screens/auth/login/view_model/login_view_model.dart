import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:sezinsoft_demo/view/screens/home/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/locator.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/base/viewmodel/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final BuildContext context;

  final Api? _Api = locator<Api>();

  LoginViewModel(this.context);

  String? _user;
  String? get user => _user;

  String? _token;
  String? get token => _token;

  setToken(String val) {
    _token = val;
    notifyListeners();
  }

  Future login({
    required String username,
    required String password,
  }) async {
    setBusy(true);
    if (kDebugMode) print("username in login $username");
    if (kDebugMode) print("password in login $password");

    var prefs = await SharedPreferences.getInstance();
    final response = await _Api!.login(username, password);
    if (kDebugMode) print("login response $response");
    if (response == null) {
      setErrorMessage('Error has occured with the login');
      showDialog(
          context: context,
          builder: (builder) => const AlertDialog(
                title: Text("ERROR"),
                content: Text("Error has occured with the login"),
              ));
    } else {
      if (response["response_text"] != "OK" || response["status_Code"] == 400) {
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  title: const Text("ERROR"),
                  content: const Text("Error has occured with the login"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OKAY"))
                  ],
                ));
      } else {
        if (response["response_text"] == "OK") {
          if (response["token"] != null) {
            if (kDebugMode) if (kDebugMode) print(response["token"]);
            prefs.setString("token", response["token"]);
            setToken(response['token']);
            Get.offAll(const HomeScreen());
          } else {
            Navigator.pop(context);
          }
        } else {}
        // await Future.delayed(Duration(seconds: 1));

      }
    }
    setBusy(false);
  }
}
