import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';


class LogoutUseSesssionUseCase {
   
  Authrepository authrepository;
  
   LogoutUseSesssionUseCase({
     required this.authrepository
   });

   run() {
      return authrepository.logout();
    }

}