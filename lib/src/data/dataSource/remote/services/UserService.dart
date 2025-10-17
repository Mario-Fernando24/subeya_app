import 'dart:io';
import 'package:dio/dio.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class Userservice {
  final Future<String> token;

  Userservice(this.token);

    Future<Resource<AuthResponse>> update(int id, User user) async {
    final authToken = await token;
    final String url = '${Apiconfig.baseUrl}/users/update/$id';

    print('================= ACTUALIZAR USUARIO =================');
    print('➡️ URL: $url');
    print('🔑 Token: $authToken');
    print('📦 Body: ${user.toJson()}');
    print('========================================================');

    try {
      final dio = Dio();

      final response = await dio.put(
        url,
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': authToken,
          },
        ),
      );

      print('✅ Respuesta: ${response.statusCode}');
      print('🧾 Datos: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse = AuthResponse.fromJson(response.data);

        return Success(userResponse);
      } else {
        return ErrorData('Error al actualizar el usuario: ${response.data}');
      }
    } on DioException catch (e) {
      print('❌ ============== ERROR DIO ==============');
      print('📡 STATUS: ${e.response?.statusCode}');
      print('💬 DATA: ${e.response?.data}');
      print('==========================================');

      String message = 'Error al procesar la solicitud.';

      if (e.response?.statusCode == 401) {
        message = 'No autorizado. Token expirado o inválido.';
      } else if (e.response?.statusCode == 404) {
        message = 'Usuario no encontrado.';
      } else if (e.response?.statusCode == 500) {
        message = 'Error interno del servidor.';
      }

      return ErrorData(message);
    } catch (e, stacktrace) {
      print('⚠️ Error inesperado: $e');
      print(stacktrace);
      return ErrorData('Error inesperado: ${e.toString()}');
    }
  }

  }
