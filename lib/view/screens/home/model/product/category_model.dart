// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

ProductCategory categoryFromJson(String str) =>
    ProductCategory.fromJson(json.decode(str));

String categoryToJson(ProductCategory data) => json.encode(data.toJson());

class ProductCategory {
  ProductCategory({
    required this.responseVal,
    required this.responseText,
    required this.data,
  });

  int responseVal;
  String responseText;
  List<Datum> data;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
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
      {required this.categoryId,
      required this.categoryName,
      required this.isSelected});

  int categoryId;
  String categoryName;
  bool isSelected;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      isSelected: false);

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
