// agregar todos los use cases de auth
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';

class Authusecases {
   
  final LoginUseCase loginUseCase;
  
   Authusecases({
    required this.loginUseCase,
   });

}