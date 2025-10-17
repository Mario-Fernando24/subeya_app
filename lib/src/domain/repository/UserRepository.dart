import 'dart:io';

import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

abstract class UserRepository {

  Future<Resource<AuthResponse>> update(int id, User user, File? imageFile);

}