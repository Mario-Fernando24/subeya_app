import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientMapaState extends Equatable {
  
  final Completer<GoogleMapController>? controller;
  final Position? position;
   
  ClientMapaState({
    this.position,
    this.controller
  });

  ClientMapaState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position
    
  }){
    return ClientMapaState(
      position: position ?? this.position,
      controller: controller ?? this.controller
    );
  }

  @override
  List<Object?> get props => [position, controller]; 


}