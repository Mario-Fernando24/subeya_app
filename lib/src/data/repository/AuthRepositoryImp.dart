import 'package:subeya/src/data/dataSource/local/sharefPref.dart';
import 'package:subeya/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class Authrepositoryimp implements  Authrepository {
   
  Authservices authservices;
  Sharefpref sharefpref;

  Authrepositoryimp(this.authservices, this.sharefpref);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authservices.login(email, password);
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authservices.register(user);
  }

   
  @override
  Future<void> saveUserSession(AuthResponse authResponse)async {
     sharefpref.save('usuario',authResponse.toJson());
  }

  @override
  Future<AuthResponse?> getUserSession() async{
     final data = await sharefpref.read('usuario');
     if(data != null){
      return AuthResponse.fromJson(data);
     }
     return null;
  }
  
  @override
  Future<bool> logout() async{
     return  await sharefpref.remove('usuario');
  }

 

}