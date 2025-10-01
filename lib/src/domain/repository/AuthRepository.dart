import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

abstract class Authrepository {

  Future<Resource<AuthResponse>> login(String email, String password);
  Future<Resource<AuthResponse>> register(User user);
  //guardar en local el usuario y token
  Future<void> saveUserSession(AuthResponse authResponse);
  //obtener el usuario y token guardado en local
  Future<AuthResponse?> getUserSession();
  //eliminar el usuario y token guardado en local
  Future<bool> logout();
  
}