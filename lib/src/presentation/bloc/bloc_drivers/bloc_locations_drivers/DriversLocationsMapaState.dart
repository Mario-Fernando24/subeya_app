import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/models/PlaceMarkData.dart';

class DriversLocationsMapaState extends Equatable {
  
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final Map<MarkerId, Marker> markers;
  final CameraPosition ? cameraPosition;
  final PlacemarkData ? placemarkData;

   
  DriversLocationsMapaState({
    this.position,
    this.controller,
    this.markers = const <MarkerId, Marker>{},
    this.cameraPosition,
    this.placemarkData,
  });

  DriversLocationsMapaState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    PlacemarkData ? placemarkData,

    
  }){
    return DriversLocationsMapaState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      placemarkData: placemarkData ?? this.placemarkData,

    );
  }

  @override
  List<Object?> get props => [position, controller, markers, cameraPosition, placemarkData]; 


}