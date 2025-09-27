
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';

class Registerusecases {

  Authrepository authrepository;

  Registerusecases(this.authrepository);

   run(User user) {
    return authrepository.register(user);
   }

}