import 'package:subeya/src/domain/repository/SocketRepository.dart';

class ConnectSocketUseCase {

  Socketrepository socketrepository;

  ConnectSocketUseCase(this.socketrepository);

  run() => socketrepository.connect();

}