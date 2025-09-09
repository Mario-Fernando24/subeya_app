import 'package:subeya/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class Authrepositoryimp implements  Authrepository {
   
  Authservices authservices = Authservices();

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authservices.login(email, password);
  }

}