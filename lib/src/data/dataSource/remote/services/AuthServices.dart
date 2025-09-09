import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class Authservices {
  Future<Resource<AuthResponse>> login(String email, String password) async {

    print("PETICION A: ${Apiconfig.baseUrl}/auth/login");
  
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        print("===============================================");
        print(authResponse.user?.toJson());
        print(authResponse.accessToken);
        print("===============================================");

        return Success(authResponse);
      } else {
        return ErrorData("Error en la autenticación: ${response.data['message']}");
      }
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['message'] ?? 'Error desconocido';
        print(message);
        return ErrorData(message);
      } else {
        print("Otro error: $e");
        return ErrorData(e.toString());
      }
    }
  }
}
