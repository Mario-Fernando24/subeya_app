abstract class DriversHomeEvent {}


class ChangeDrawerIndex extends DriversHomeEvent{
  
  final int index;
  ChangeDrawerIndex({ required this.index});

}

class Logout extends DriversHomeEvent{}