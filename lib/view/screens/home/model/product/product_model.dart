// To parse required this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.responseVal,
    required this.responseText,
    required this.data,
  });

  int responseVal;
  String responseText;
  List<Datum> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        responseVal: json["response_val"],
        responseText: json["response_text"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_val": responseVal,
        "response_text": responseText,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {required this.productId,
      required this.productName,
      required this.productPrice,
      required this.productCurrency,
      required this.productPhoto,
      required this.categoryId,
      required this.categoryName,
      required this.count});

  int productId;
  String productName;
  double productPrice;
  String productCurrency;
  String productPhoto;
  int categoryId;
  String categoryName;
  int count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      productId: json["product_id"],
      productName: json["product_name"],
      productPrice: json["product_price"].toDouble(),
      productCurrency: json["product_currency"],
      productPhoto: json["product_photo"],
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      count: 0);

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_price": productPrice,
        "product_currency": productCurrency,
        "product_photo": productPhoto,
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
