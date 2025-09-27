import 'package:injectable/injectable.dart';
import 'package:subeya/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:subeya/src/data/repository/AuthRepositoryImp.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/RegisterUseCases.dart';

@module
abstract class AppModule {
   
   @injectable 
  Authservices get authservices => Authservices();

  @injectable
  Authrepository get authrepository => Authrepositoryimp(authservices);

  @injectable
  Authusecases get authusecases => Authusecases(
    loginUseCase: LoginUseCase(authrepository),
    registerUseCase: Registerusecases(authrepository),
  );  



}