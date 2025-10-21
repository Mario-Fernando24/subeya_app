abstract class  ClientMapaEvent {}

class ClientMapInicializarEvento extends ClientMapaEvent{}

class FindPosition extends ClientMapaEvent{}


class ChangeMapCameraPosition extends ClientMapaEvent{
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
     required this.lat,
     required this.lng
  });
  
}

