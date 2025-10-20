import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';

class ClientMapaBloc extends Bloc<ClientMapaEvent, ClientMapaState> {

  GeolocatorUseCase geolocatorUseCase;

    ClientMapaBloc(this.geolocatorUseCase) : super(ClientMapaState())  {

      on<FindPosition>((event, emit) async {

      Position position = await geolocatorUseCase.findPositionUsecase.run();
      
      emit(
        state.copyWith(
          position: position
        )
      );

      print("Latitud::::: ${position.latitude} Longitud::::: ${position.longitude}");
        
      });
  
    }


}