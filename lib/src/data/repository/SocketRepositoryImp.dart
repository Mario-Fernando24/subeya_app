import 'package:socket_io_client/src/socket.dart';
import 'package:subeya/src/domain/repository/SocketRepository.dart';

class SocketRepositoryImp implements Socketrepository {

  Socket socket;

  SocketRepositoryImp(this.socket);

  @override
  Socket connect() {
     return socket.connect();
  }

  @override
  Socket disconect() {
     return socket.disconnect();
  }


}
