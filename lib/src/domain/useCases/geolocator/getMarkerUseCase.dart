import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';

class GetMarkerUsecase {
  final GeolocatorRepository geolocatorRepository;

  GetMarkerUsecase(this.geolocatorRepository);

  Future<Marker> run(
    String markerId,
    double lat,
    double lng,
    String title,
    String content,
    BitmapDescriptor icon,
  ) async {
    return geolocatorRepository.getMarker(
      markerId,
      lat,
      lng,
      title,
      content,
      icon,
    );
  }
}
