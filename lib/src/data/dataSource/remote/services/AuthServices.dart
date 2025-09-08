import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';
import 'package:subeya/src/domain/models/auth_response.dart';

class Authservices {
  Future<AuthResponse?> login(String email, String password) async {
    try {
      Dio dio = Dio();
      // URL de tu API
      String url = "${Apiconfig.baseUrl}/auth/login";
      // Headers
      dio.options.headers = {'Content-Type': 'application/json'};
      // Body
      Map<String, dynamic> body = {'email': email, 'password': password};
      // Petición POST
      final response = await dio.post(url, data: json.encode(body));

      AuthResponse authResponse = AuthResponse.fromJson(response.data);

      print("===============================================");
      print(authResponse.user?.toJson());
      print(authResponse.accessToken);
      print("===============================================");

      return authResponse;
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['message'] ?? 'Error desconocido';
        print(message);
        return null;
      } else {
        print("Otro error: $e");
        return null;
      }
    }
  }
}
