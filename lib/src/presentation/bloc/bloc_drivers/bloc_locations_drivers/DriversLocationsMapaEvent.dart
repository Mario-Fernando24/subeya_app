import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class  DriversLocationsMapaEvent {}

class DriversMapInicializarEvento extends DriversLocationsMapaEvent{}

class FindPositionDrivers extends DriversLocationsMapaEvent{}


class ChangeMapCameraPosition extends DriversLocationsMapaEvent{
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
     required this.lat,
     required this.lng
  });
  
}

class CameraPositionChangedDriversEvent extends DriversLocationsMapaEvent{
  
  CameraPosition cameraPosition;

  CameraPositionChangedDriversEvent({
    required this.cameraPosition
  });
  
}

class UpdateLocationsPositionStreamDriversEvent extends DriversLocationsMapaEvent{
    
    final Position position;

    UpdateLocationsPositionStreamDriversEvent({
      required this.position
    });

}

class StopLocationsPositionStreamDriversEvent extends DriversLocationsMapaEvent{}

class AddMyPositionMarkerDriversEvent extends DriversLocationsMapaEvent{
  
  final double latitud;
  final double longitud;

  AddMyPositionMarkerDriversEvent({
    required this.latitud,
    required this.longitud
  });
  
}


 

