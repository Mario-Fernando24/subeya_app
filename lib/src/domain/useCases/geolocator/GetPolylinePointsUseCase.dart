
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';

class GetPolylinePointsUsecase {

  GeolocatorRepository repository;

  GetPolylinePointsUsecase(this.repository);

  run(LatLng lugarRecogidad,LatLng lugarDestino)=> repository.getPolylineCoordinates(lugarRecogidad, lugarDestino);
  
}