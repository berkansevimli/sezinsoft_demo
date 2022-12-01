import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_urls.dart';

/// The service responsible for networking requests
class Api {
  var client = new http.Client();

  Future<dynamic> login(String username, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var newJson = <String, dynamic>{
        "username": username,
        "password": password
      };
      final response = await client.post(
        Uri.parse(loginURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newJson),
      );
      return json.decode(response.body);
    } catch (e) {
      if (kDebugMode) print("Could Not Load Data login: $e");
      return null;
    }
  }

  Future<dynamic> getUser(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var newJson = <String, dynamic>{
        "token": token,
      };
      final response = await client.post(
        Uri.parse(getUserURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newJson),
      );
      return json.decode(response.body);
    } catch (e) {
      if (kDebugMode) print("Could Not Load Data getUser: $e");
      return null;
    }
  }
}
