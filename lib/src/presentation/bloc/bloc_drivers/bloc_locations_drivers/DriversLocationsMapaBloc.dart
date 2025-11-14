import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/domain/useCases/socket/socketUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaState.dart';

class DriversLocationsMapaBloc extends Bloc<DriversLocationsMapaEvent, DriversLocationsMapaState> {

  GeolocatorUseCase geolocatorUseCase;
  StreamSubscription ? positionSubscription;
  SocketUseCase socketUseCase;

  DriversLocationsMapaBloc(this.geolocatorUseCase, this.socketUseCase) : super(DriversLocationsMapaState()) {
    on<DriversMapInicializarEvento>((event, emit) {
      // Controlador del mapa (permite mover la cámara, añadir marcadores, etc.)
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPositionDrivers>((event, emit) async {
      Position position = await geolocatorUseCase.findPositionUsecase.run();
      // mover la cámara a la posición actual
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      // añadir marcador de la posición actual
      add(AddMyPositionMarkerDriversEvent(latitud: position.latitude, longitud: position.longitude));
      Stream<Position> positionStream = geolocatorUseCase.getPositionsStreamsUsecase.run();
        // escuchar el stream de posiciones
        positionSubscription = positionStream.listen((Position position) {
           add(UpdateLocationsPositionStreamDriversEvent(position: position));
        });      
       // actualizar el estado con la nueva posición
        emit(
          state.copyWith(
            position: position
         ));  
           
    });
    
    on<AddMyPositionMarkerDriversEvent>((event, emit) async {
      BitmapDescriptor descriptor = await geolocatorUseCase.createmarketUsecase.run('assets/img/car_pin.png');
      // crear el marcador de la posición actual
      Marker marker = await geolocatorUseCase.getMarkerUsecase.run(
        'MyLocationnS',event.latitud, event.longitud,'Mi posición','',descriptor
      );
        // ✅ Clonamos los marcadores actuales y actualizamos la posición
          final updatedMarkers = Map<MarkerId, Marker>.from(state.markers);
          updatedMarkers[marker.markerId] = marker;

          emit(
            state.copyWith(
              markers: updatedMarkers,
            ),
          );
        });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController contro = await state.controller!.future;
     await contro.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 17,
            bearing: 0,
          ),
        ),
      );
    });

    on<CameraPositionChangedDriversEvent>((event, emit) async {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });

    on<UpdateLocationsPositionStreamDriversEvent>((event, emit) async {
      print('ciudad Nueva posición recibida: ${event.position.latitude}, ${event.position.longitude} ');
      add(AddMyPositionMarkerDriversEvent(latitud: event.position.latitude, longitud: event.position.longitude));
      add(ChangeMapCameraPosition(lat:  event.position.latitude, lng:  event.position.longitude));

         emit(
          state.copyWith(
            position: event.position
         ));
      });  

    // guardar la suscripción en el estado para poder cancelarla más tarde
    on<StopLocationsPositionStreamDriversEvent>((event, emit) async {
      positionSubscription?.cancel();
  });

  on<ConnectSocketIo>((event, emit) async {
     socketUseCase.connect.run();
  });

  on<DesconnectSocketIo>((event, emit) async {
    socketUseCase.disconnect.run();
  }); 

  }


  

}
