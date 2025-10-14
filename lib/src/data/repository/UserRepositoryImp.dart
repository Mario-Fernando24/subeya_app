import 'dart:io';

import 'package:subeya/src/data/dataSource/remote/services/UserService.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/repository/UserRepository.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class UserRepositoryImp implements  UserRepository {

  Userservice userService;

  UserRepositoryImp( this.userService);
  
  @override
  Future<Resource<User>> update(int id, User user, File? imageFile) {
    return userService.update(id, user, imageFile);
  }


}
  