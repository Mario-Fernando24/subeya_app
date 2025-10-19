// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:subeya/src/domain/models/user_model.dart';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
    User ?user;
    String ?accessToken;

    AuthResponse({
        this.user,
        this.accessToken,
    });

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        //user: User.fromJson(json["user"]),
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
       // "user": user!.toJson(),
       "user": user != null ? user!.toJson() : null,
       "access_token": accessToken,
    };
}