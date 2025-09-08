import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';

class Authservices {
  Future<dynamic> login(String email, String password) async {
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

      print("--------------------------------------------------");
      print('Data Remote: ${response.data}');
      print("--------------------------------------------------");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print("Error code: ${e.response?.statusCode}");
        print("Error data: ${e.response?.data}");
        return e.response?.data; // opcional: devolver lo que mandó el backend
      } else {
        print("Otro error: $e");
      }
      return null;
    }
  }
}
