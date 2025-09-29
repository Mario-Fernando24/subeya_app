// agregar todos los use cases de auth
import 'package:subeya/src/domain/useCases/auth/GetUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/RegisterUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/SaveUseSessionUseCase.dart';

class Authusecases {
   
  final LoginUseCase loginUseCase;
  final Registerusecases registerUseCase;
  final SaveUseSessionUseCase saveUseSessionUseCase;
  final GetUseSessionUseCase getUseSessionUseCase;
  
   Authusecases({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.saveUseSessionUseCase,
    required this.getUseSessionUseCase  
   });

}