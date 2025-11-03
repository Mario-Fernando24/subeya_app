import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente_info/ClientMapaInfoEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente_info/ClientMapaInfoState.dart';

class ClientMapaInfoBloc extends Bloc<ClientMapaInfoEvent, ClientMapaInfoState> {
  
  GeolocatorUseCase geolocatorUseCase;

  ClientMapaInfoBloc(this.geolocatorUseCase) : super(ClientMapaInfoState()) {

    on<ClientMapInicializarEventoInfo>((event, emit) {
      // Controlador del mapa (permite mover la cámara, añadir marcadores, etc.)
      final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller,
          lugarRecogidaLatLng: event.lugarInicialInfo,
          lugarDestinoLatLng: event.lugarDestinoInfo,
          lugarRecogidaText: event.descripcionLugarInicialInfo,
          lugarDestinoText: event.descripcionLugarDestinoInfo
          )
        );
    });
    // Evento para cambiar la posición de la cámara del mapa
    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController contro = await state.controller!.future;
      await contro.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 14,
            bearing: 0,
          ),
        ),
      );
    });
  

  on<AddPolylinesToMapEvent>((event, emit) async {
    if (state.lugarRecogidaLatLng != null && state.lugarDestinoLatLng != null) {
      // Obtener las coordenadas de la polilínea entre los dos puntos
      List<LatLng> polylineCoordinates = await geolocatorUseCase.getPolylinePointsUsecase.run(
        state.lugarRecogidaLatLng!,
        state.lugarDestinoLatLng!
      );

      // Crear la polilínea
      final PolylineId polylineId = PolylineId('route_polyline');
      final Polyline polyline = Polyline(
        polylineId: polylineId,
        color: const Color(0xFF4285F4),
        width: 5,
        points: polylineCoordinates,
        
      );

      // Añadir la polilínea al estado actual
      final Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
      polylines[polylineId] = polyline;

      // Emitir el nuevo estado con la polilínea añadida
      emit(state.copyWith(
        // Aquí deberías añadir la lógica para manejar las polilíneas en el estado
        // Por ejemplo, podrías tener un campo adicional en el estado para las polilíneas
        polylines: { 
          ...state.polylines,
          polylineId: polyline
        }
      ));
    }
  }); 

}
}
