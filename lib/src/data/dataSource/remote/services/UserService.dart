import 'dart:io';

import 'package:dio/dio.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class Userservice {
   
   // Actualiza un usuario con datos y una imagen opcional
   Future<Resource<User>> update(int userId, User user, File? imageFile) async {

    try {
      Dio dio = Dio();
      // URL de tu API
      String url = "${Apiconfig.baseUrl}/users/update/$userId";
      // Headers
      dio.options.headers = {
        'Content-Type': 'application/json',
        // Agrega aquí el token de autenticación si es necesario
        // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      };
      // Body
      Map<String, dynamic> body = user.toJson();

      FormData formData = FormData.fromMap(body);

      if (imageFile != null) {
        String fileName = imageFile.path.split('/').last;
        formData.files.add(MapEntry(
          'profileImage',
          await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ));
      }

      // Petición PUT
      final response = await dio.put(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        User updatedUser = User.fromJson(response.data);
  

        return Success(updatedUser);
      } else {
        return ErrorData("Error al actualizar el usuario: ${response.data['message']}");
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