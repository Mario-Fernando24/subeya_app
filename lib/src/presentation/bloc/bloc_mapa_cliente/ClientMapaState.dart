import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientMapaState extends Equatable {
  
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final Map<MarkerId, Marker> markers;
   
  ClientMapaState({
    this.position,
    this.controller,
    this.markers = const <MarkerId, Marker>{}
  });

  ClientMapaState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    Map<MarkerId, Marker>? markers
    
  }){
    return ClientMapaState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      markers: markers ?? this.markers
    );
  }

  @override
  List<Object?> get props => [position, controller, markers]; 


}