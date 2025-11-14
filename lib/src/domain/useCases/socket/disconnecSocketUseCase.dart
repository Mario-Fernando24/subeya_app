import 'package:subeya/src/domain/repository/SocketRepository.dart';

class DisconnectSocketUseCase {

  Socketrepository socketrepository;

  DisconnectSocketUseCase(this.socketrepository);

  run() => socketrepository.disconect();

}