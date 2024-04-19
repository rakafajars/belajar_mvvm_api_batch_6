// To parse this JSON data, do
//
//     final requestLoginModel = requestLoginModelFromJson(jsonString);

import 'dart:convert';

RequestLoginModel requestLoginModelFromJson(String str) => RequestLoginModel.fromJson(json.decode(str));

String requestLoginModelToJson(RequestLoginModel data) => json.encode(data.toJson());

class RequestLoginModel {
    String? username;
    String? password;

    RequestLoginModel({
        this.username,
        this.password,
    });

    factory RequestLoginModel.fromJson(Map<String, dynamic> json) => RequestLoginModel(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}
