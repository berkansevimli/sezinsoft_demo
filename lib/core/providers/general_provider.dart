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

  void minusCount(Datum e) {
    int index = _shoppingList!
        .indexWhere((element) => element.productId == e.productId);
    if (_shoppingList![index].count == 1) {
      _shoppingList!.removeAt(index);
      notifyListeners();
    } else {
      _shoppingList![index].count = _shoppingList![index].count - 1;
    }
    notifyListeners();
  }

  void plusCount(Datum e) {
    int index = _shoppingList!
        .indexWhere((element) => element.productId == e.productId);
    _shoppingList![index].count = _shoppingList![index].count + 1;

    notifyListeners();
  }
}
