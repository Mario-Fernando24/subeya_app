abstract class  ClientMapaEvent {}

class FindPosition extends ClientMapaEvent{}

class ClientMapInicializarEvento extends ClientMapaEvent{}

class ChangeMapCameraPosition extends ClientMapaEvent{
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
     required this.lat,
     required this.lng
  });
  
}

