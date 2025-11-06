import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaState.dart';

class DriversLocationsMapaBloc extends Bloc<DriversLocationsMapaEvent, DriversLocationsMapaState> {
  GeolocatorUseCase geolocatorUseCase;
  

  DriversLocationsMapaBloc(this.geolocatorUseCase) : super(DriversLocationsMapaState()) {
    on<DriversMapInicializarEvento>((event, emit) {
      // Controlador del mapa (permite mover la cámara, añadir marcadores, etc.)
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPositionDrivers>((event, emit) async {
      Position position = await geolocatorUseCase.findPositionUsecase.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));


      BitmapDescriptor descriptor = await geolocatorUseCase.createmarketUsecase.run('assets/img/car_pin.png');

      Marker marker = await geolocatorUseCase.getMarkerUsecase.run(
        'MyLocationnS',position.latitude, position.longitude,'Mi posición','',descriptor
      );

      emit(
        state.copyWith(
         position: position,
         markers: { marker.markerId: marker } ,
        //  controller: controller,
       )
      );

    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController contro = await state.controller!.future;
     await contro.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 15,
            bearing: 0,
          ),
        ),
      );
    });

    on<CameraPositionChangedDriversEvent>((event, emit) async {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });

  }

}
