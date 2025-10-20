import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';

class ClientMapaBloc extends Bloc<ClientMapaEvent, ClientMapaState> {
  GeolocatorUseCase geolocatorUseCase;
  // Controlador del mapa (permite mover la cámara, añadir marcadores, etc.)
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  ClientMapaBloc(this.geolocatorUseCase) : super(ClientMapaState()) {
    on<ClientMapaEvent>((event, emit) {
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCase.findPositionUsecase.run();

      emit(state.copyWith(position: position, controller: controller));

      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      print("Latitud::::: ${position.latitude} Longitud::::: ${position.longitude}",
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController contro = await state.controller!.future;
      contro.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 13,
            bearing: 0,
          ),
        ),
      );
    });
  }
}
