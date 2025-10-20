import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class ClientMapaState extends Equatable {
  
  final Position? position;
   
  ClientMapaState({
    this.position
  });

  ClientMapaState copyWith({
    Position? position
  }){
    return ClientMapaState(
      position: position ?? this.position
    );
  }

  @override
  List<Object?> get props => [position]; 


}