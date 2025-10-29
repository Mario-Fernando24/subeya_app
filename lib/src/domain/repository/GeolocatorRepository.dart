
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:subeya/src/domain/models/PlaceMarkData.dart';

abstract class GeolocatorRepository {

  Future<Position> findPosition();
  Future<BitmapDescriptor> createMarkerFromAsset(String path);
  Marker getMarker(
    String markeId,
    double lat,
    double lng,
    String title,
    String content,
    BitmapDescriptor imageMarke
  );

  // 
  Future<PlacemarkData?> getPlaceData(CameraPosition position);

}