import 'package:subeya/src/data/repository/AuthRepositoryImp.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';

class LoginUseCase {

   Authrepository authrepository = Authrepositoryimp();

   run(String email, String password){
     return authrepository.login(email, password);
   }
}