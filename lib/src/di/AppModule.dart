import 'package:injectable/injectable.dart';
import 'package:subeya/src/data/dataSource/local/sharefPref.dart';
import 'package:subeya/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:subeya/src/data/dataSource/remote/services/UserService.dart';
import 'package:subeya/src/data/repository/AuthRepositoryImp.dart';
import 'package:subeya/src/data/repository/UserRepositoryImp.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';
import 'package:subeya/src/domain/repository/UserRepository.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/LogoutUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/GetUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/RegisterUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/SaveUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/users/UpdateUserUseCase.dart';
import 'package:subeya/src/domain/useCases/users/UsersUseCase.dart';

@module
abstract class AppModule {

    @injectable
  Sharefpref get sharefpref => Sharefpref();


  @injectable
  Future<String> get token async {
    String token = '';
             AuthResponse? response  =  await authusecases.getUseSessionUseCase.run();

    if(response != null){
      AuthResponse authResponse = AuthResponse.fromJson(response.toJson());
      print(' TOKEN MARIO FERNANDO: ${authResponse.accessToken}');
      print(' TOKEN: ${authResponse.accessToken}');
       token = authResponse.accessToken ?? '';
       return token;
    }
    return token; 
  }
   
   @injectable 
  Authservices get authservices => Authservices();

  @injectable
  Userservice get userservice => Userservice(token);

  @injectable
  Authrepository get authrepository => Authrepositoryimp(authservices,sharefpref);

  @injectable
  UserRepository get userRepository => UserRepositoryImp(userservice);

  @injectable
  Authusecases get authusecases => Authusecases(
    loginUseCase: LoginUseCase(authrepository),
    registerUseCase: Registerusecases(authrepository),
    getUseSessionUseCase: GetUseSessionUseCase(authrepository:  authrepository),
    saveUseSessionUseCase: SaveUseSessionUseCase(authrepository: authrepository),
    logoutUseSesssionUseCase: LogoutUseSesssionUseCase(authrepository: authrepository),
  );  


  @injectable
  UsersUseCase get useCaseUse => UsersUseCase(
    updateUserUseCase: UpdateUserUseCase(userRepository),
  );  



}