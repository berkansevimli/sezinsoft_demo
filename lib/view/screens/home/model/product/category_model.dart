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
  List<CategoryData> data;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        responseVal: json["response_val"],
        responseText: json["response_text"],
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_val": responseVal,
        "response_text": responseText,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CategoryData {
  CategoryData(
      {required this.categoryId,
      required this.categoryName,
      required this.isSelected});

  int categoryId;
  String categoryName;
  bool isSelected;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      isSelected: false);

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
