import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';


class SaveUseSessionUseCase {
   
  Authrepository authrepository;
  
   SaveUseSessionUseCase({
     required this.authrepository
   });

   run(AuthResponse authResponse) {
    return authrepository.saveUserSession(authResponse);
   }

}