import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/models/PlaceMarkData.dart';

class ClientMapaInfoState extends Equatable {
  
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final Map<MarkerId, Marker> markers;
  final CameraPosition ? cameraPosition;
  final LatLng? lugarRecogidaLatLng;
  final LatLng? lugarDestinoLatLng;
  final String? lugarRecogidaText;
  final String? lugarDestinoText ;
  final Map<PolylineId, Polyline> polylines;

   
  ClientMapaInfoState({
    this.position,
    this.controller,
    this.markers = const <MarkerId, Marker>{},
    this.cameraPosition,
    this.lugarRecogidaLatLng,
    this.lugarDestinoLatLng,
    this.lugarRecogidaText,
    this.lugarDestinoText,
    this.polylines = const <PolylineId, Polyline>{},
  });

  ClientMapaInfoState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    LatLng? lugarRecogidaLatLng,
    LatLng? lugarDestinoLatLng,
    String? lugarRecogidaText,
    String? lugarDestinoText,
    Map<PolylineId, Polyline>? polylines,
  }){
    return ClientMapaInfoState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      lugarRecogidaLatLng: lugarRecogidaLatLng ?? this.lugarRecogidaLatLng,
      lugarDestinoLatLng: lugarDestinoLatLng ?? this.lugarDestinoLatLng,
      lugarRecogidaText: lugarRecogidaText ?? this.lugarRecogidaText,
      lugarDestinoText: lugarDestinoText ?? this.lugarDestinoText,
      polylines: polylines ?? this.polylines,

    );
  }

  @override
  List<Object?> get props => [position, controller, markers, cameraPosition, lugarRecogidaLatLng, lugarDestinoLatLng, lugarRecogidaText, lugarDestinoText, polylines]; 


}