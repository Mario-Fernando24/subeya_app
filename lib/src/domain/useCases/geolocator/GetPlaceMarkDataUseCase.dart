import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/models/PlaceMarkData.dart';
import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';

class GetplacemarkDataUsecase {

  GeolocatorRepository repository;

  GetplacemarkDataUsecase(this.repository);

  run(CameraPosition posicion)=> repository.getPlaceData(posicion);


}