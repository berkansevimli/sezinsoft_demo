import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sezinsoft_demo/view/screens/home/model/product/category_model.dart';
import 'package:sezinsoft_demo/view/screens/home/model/product/product_model.dart';

import 'package:sezinsoft_demo/view/screens/home/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/locator.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/base/viewmodel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final BuildContext context;

  final Api? _Api = locator<Api>();

  HomeViewModel(this.context);
  String? _token;
  String? get token => _token;

  setToken(String val) {
    _token = val;
    notifyListeners();
  }

  User? _user;
  User? get user => _user;

  setUser(User val) {
    _user = val;
    notifyListeners();
  }

  ProductCategory? _category;
  ProductCategory? get category => _category;

  setCategory(ProductCategory val) {
    _category = val;
    notifyListeners();
  }

  ProductModel? _products;
  ProductModel? get products => _products;

  setProduct(ProductModel val) {
    _products = val;
    notifyListeners();
  }

  Future getUser({
    required String token,
  }) async {
    setBusy(true);
    var prefs = await SharedPreferences.getInstance();

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
      prefs.setString("user_token", response["data"]["token"]);

      User user = User.fromJson(response);
      setUser(user);
    }
    setBusy(false);
  }

  Future getCategories({
    required String token,
  }) async {
    setBusy(true);
    final response = await _Api!.getCategories(token);
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
      ProductCategory productCategory = ProductCategory.fromJson(response);
      productCategory.data.first.isSelected = true;
      setCategory(productCategory);
    }
    setBusy(false);
  }

  Future getProducts({
    required String token,
    required int id,
  }) async {
    setBusy(true);
    print("token: " + token);
    final response = await _Api!.getProducts(token, id);
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
      ProductModel productCategory = ProductModel.fromJson(response);
      setProduct(productCategory);
    }
    setBusy(false);
  }
}
