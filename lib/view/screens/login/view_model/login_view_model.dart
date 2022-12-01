import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:sezinsoft_demo/view/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/locator.dart';
import '../../../../core/api/api.dart';
import '../../../../core/base/viewmodel/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final BuildContext context;

  final Api? _Api = locator<Api>();

  RegisterViewModel(this.context);

  String? _user;
  String? get user => _user;

  String? _access_token;
  String? get access_token => _access_token;

  Future login({
    required String email,
    required String password,
  }) async {
    setBusy(true);
    print("email in login $email");
    print("password in login $password");

    var _prefs = await SharedPreferences.getInstance();
    final response = await _Api!.login(email, password);
    print("login response $response");
    if (response == null) {
      setErrorMessage('Error has occured with the login');
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("ERROR"),
                content: Text("Error has occured with the login"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OKAY"))
                ],
              ));
      // await _dialogService!.showDialog(
      //     title: "Error!",
      //     description: "Error has occured with the login",
      //     buttonTitle: "Tamam");
    } else {
      
      if (response["response_text"] != "OK" || response["status_Code"] == 400) {
        
       showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("ERROR"),
                content: Text("Error has occured with the login"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OKAY"))
                ],
              ));

       
      } else {
       
        if (response["response_text"] == "OK") {
          if (response["token"] != null) {

            if (kDebugMode) print(response["token"]);
            
            _prefs.setString("token", response["token"]);

            _prefs.setString("1defa_giris", "true");

            Get.offAll(const HomeScreen());

            // notifyListeners();
            //
            // _navigationService.navigateToUntil(routes.firstHomeRoute,arguments: {"currentIndex":0,"initialIndex":0});
          } else {
            Navigator.pop(context);
          }
        } else {
         
        }
        // await Future.delayed(Duration(seconds: 1));

      }
    }
    setBusy(false);
  }
}
