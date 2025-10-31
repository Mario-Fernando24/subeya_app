import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/models/PlaceMarkData.dart';

class ClientMapaState extends Equatable {
  
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final Map<MarkerId, Marker> markers;
  final CameraPosition ? cameraPosition;
  final PlacemarkData ? placemarkData;
  final LatLng? lugarRecogidaLatLng;
  final LatLng? lugarDestinoLatLng;
  final String? lugarRecogidaText;
  final String? lugarDestinoText ;
   
  ClientMapaState({
    this.position,
    this.controller,
    this.markers = const <MarkerId, Marker>{},
    this.cameraPosition,
    this.placemarkData,
    this.lugarRecogidaLatLng,
    this.lugarDestinoLatLng,
    this.lugarRecogidaText,
    this.lugarDestinoText,
  });

  ClientMapaState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    PlacemarkData ? placemarkData,
    LatLng? lugarRecogidaLatLng,
    LatLng? lugarDestinoLatLng,
    String? lugarRecogidaText,
    String? lugarDestinoText,
    
  }){
    return ClientMapaState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      placemarkData: placemarkData ?? this.placemarkData,
      lugarRecogidaLatLng: lugarRecogidaLatLng ?? this.lugarRecogidaLatLng,
      lugarDestinoLatLng: lugarDestinoLatLng ?? this.lugarDestinoLatLng,
      lugarRecogidaText: lugarRecogidaText ?? this.lugarRecogidaText,
      lugarDestinoText: lugarDestinoText ?? this.lugarDestinoText,

    );
  }

  @override
  List<Object?> get props => [position, controller, markers, cameraPosition, placemarkData, lugarRecogidaLatLng, lugarDestinoLatLng, lugarRecogidaText, lugarDestinoText]; 


}