import 'dart:io';

import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

abstract class UserRepository {

  Future<Resource<User>> update(int id, User user, File? imageFile);

}