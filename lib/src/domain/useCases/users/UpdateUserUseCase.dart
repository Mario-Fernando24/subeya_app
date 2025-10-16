import 'package:subeya/src/domain/repository/UserRepository.dart';

class UpdateUserUseCase {

   UserRepository userRepository;

   UpdateUserUseCase(this.userRepository);

   run(int id, user, imageFile) {
     return userRepository.update(id, user, imageFile);
   }
}