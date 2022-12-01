import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.responseVal,
    required this.responseText,
    required this.data,
  });

  int responseVal;
  String responseText;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        responseVal: json["response_val"],
        responseText: json["response_text"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response_val": responseVal,
        "response_text": responseText,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.name,
  });

  String token;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
      };
}
