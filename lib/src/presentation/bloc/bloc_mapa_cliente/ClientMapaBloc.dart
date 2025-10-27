import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';

class ClientMapaBloc extends Bloc<ClientMapaEvent, ClientMapaState> {
  GeolocatorUseCase geolocatorUseCase;
  

  ClientMapaBloc(this.geolocatorUseCase) : super(ClientMapaState()) {
    on<ClientMapInicializarEvento>((event, emit) {
      // Controlador del mapa (permite mover la cámara, añadir marcadores, etc.)
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCase.findPositionUsecase.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));


      BitmapDescriptor imageMarkets = await geolocatorUseCase.createmarketUsecase.run('assets/img/location_home_4.png');

      print("mario fernando munoz");
      print(imageMarkets.toJson());
      print("mario fernando munoz");

      print('___________________________________________');
      print(position.toJson());
      print('___________________________________________');
      Marker marker = await geolocatorUseCase.getMarkerUsecase.run(
        'MyLocation',position.latitude, position.longitude,'Mi posición','',imageMarkets
      );

      print("Latitud::::: ${position.latitude} Longitud::::: ${position.longitude}");

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
            zoom: 16,
            bearing: 0,
          ),
        ),
      );
    });
  }
}
