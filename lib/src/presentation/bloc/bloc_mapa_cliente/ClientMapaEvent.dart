import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class CameraPositionChangedEvent extends ClientMapaEvent{
  
  CameraPosition cameraPosition;

  CameraPositionChangedEvent({
    required this.cameraPosition
  });
  
}

class OnCameraIdleEvent extends ClientMapaEvent{

}

