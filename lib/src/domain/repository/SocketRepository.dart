import 'package:socket_io_client/socket_io_client.dart';

abstract class Socketrepository {

  Socket connect();
  Socket disconect();

}