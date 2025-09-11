import 'package:subeya/src/domain/repository/AuthRepository.dart';

class LoginUseCase {

   Authrepository authrepository;

   LoginUseCase(this.authrepository);

   run(String email, String password){
     return authrepository.login(email, password);
   }
}