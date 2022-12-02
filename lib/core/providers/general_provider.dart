import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sezinsoft_demo/view/screens/home/model/product/product_model.dart';

class GeneralProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  List<Datum>? _shoppingList = [];
  List<Datum>? get shoppingList => _shoppingList;

  void addShoppingList(Datum val) {
    _shoppingList!.add(val);
    notifyListeners();
  }

  void updateCount(int index, bool isAdd) {
    _shoppingList![index].count = isAdd
        ? _shoppingList![index].count + 1
        : _shoppingList![index].count - 1;
    notifyListeners();
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
