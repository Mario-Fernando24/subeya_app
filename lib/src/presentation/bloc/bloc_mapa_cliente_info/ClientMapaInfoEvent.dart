import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class  ClientMapaInfoEvent {}

class ClientMapInicializarEventoInfo extends ClientMapaInfoEvent{
  final LatLng? lugarInicialInfo;
  final LatLng? lugarDestinoInfo;
  final String? descripcionLugarInicialInfo;
  final String? descripcionLugarDestinoInfo;

  ClientMapInicializarEventoInfo({
    this.lugarInicialInfo,
    this.lugarDestinoInfo,
    this.descripcionLugarInicialInfo,
    this.descripcionLugarDestinoInfo
  });

}

// Evento para añadir las lineas polilíneas al mapa
class AddPolylinesToMapEvent extends ClientMapaInfoEvent{}

class ChangeMapCameraPosition extends ClientMapaInfoEvent{
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
     required this.lat,
     required this.lng
  });
  
}

