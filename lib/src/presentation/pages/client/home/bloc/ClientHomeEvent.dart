abstract class ClientHomeEvent {}


class ChangeDrawerIndex extends ClientHomeEvent{
  
  final int index;
  ChangeDrawerIndex({ required this.index});

}