
import 'package:subeya/src/domain/useCases/socket/connectSocketUseCase.dart';
import 'package:subeya/src/domain/useCases/socket/disconnecSocketUseCase.dart';

class SocketUseCase {

  ConnectSocketUseCase connect;
  DisconnectSocketUseCase disconnect;

   SocketUseCase({
    required this.connect,
    required this.disconnect
   });

}