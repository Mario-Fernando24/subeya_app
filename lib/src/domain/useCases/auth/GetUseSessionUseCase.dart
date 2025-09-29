import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';


class GetUseSessionUseCase {
   
  Authrepository authrepository;
  
   GetUseSessionUseCase({
     required this.authrepository
   });

   run() {
      return authrepository.getUserSession();
    }

}