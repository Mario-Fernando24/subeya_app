// agregar todos los use cases de auth
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/RegisterUseCases.dart';

class Authusecases {
   
  final LoginUseCase loginUseCase;
  final Registerusecases registerUseCase;
  
   Authusecases({
    required this.loginUseCase,
    required this.registerUseCase,
   });

}