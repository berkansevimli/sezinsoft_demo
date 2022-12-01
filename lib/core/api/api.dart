import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../constants/api_urls.dart';
import '../locator.dart';

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
}
