import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';
import 'package:subeya/src/domain/models/PlaceMarkData.dart';
import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';
import 'package:geocoding/geocoding.dart';


class Geolocartorrepositoryimpl implements GeolocatorRepository {

  /// Método principal para obtener la posición actual del usuario.
  /// Retorna un objeto [Position] con latitud, longitud, precisión, etc.
  /// Si los servicios de ubicación están deshabilitados o los permisos son denegados,
  /// lanza un error (Future.error).
  @override
  Future<Position> findPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1️⃣ Verificar si los servicios de ubicación del dispositivo están activados.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Si los servicios están deshabilitados, no se puede continuar.
      // Se retorna un Future con un error explicativo.
      return Future.error('Location services are disabled.');
    }

    // 2️⃣ Verificar si la app tiene permisos para acceder a la ubicación.
    permission = await Geolocator.checkPermission();

    // Si no tiene permiso, se solicita al usuario.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // Si el usuario vuelve a denegar el permiso, se lanza un error.
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // 3️⃣ Verificar si el permiso fue denegado permanentemente (usuario marcó "No volver a preguntar").
    if (permission == LocationPermission.deniedForever) {
      // En este caso no se puede pedir el permiso nuevamente desde la app.
      // Se recomienda mostrar un mensaje para que el usuario lo habilite manualmente en ajustes.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 4️⃣ Si llegamos hasta aquí, los permisos están concedidos y los servicios habilitados.
    // Se obtiene la posición actual del dispositivo (latitud, longitud, etc.).
    return await Geolocator.getCurrentPosition();
  }

   @override
  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(), // ✅ configuración vacía
      path, // ✅ ruta al asset
    );
  }


  

  @override
  Marker getMarker(String markeId, double lat, double lng, String title, String content, BitmapDescriptor imageMarke) {
    MarkerId id = MarkerId(markeId);
    Marker marker = Marker(
      markerId: id, 
      icon: imageMarke,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content)
      );

      return marker;
  }

 // esta función obtiene información del lugar basado en la posición de la cámara del mapa
  @override
  Future<PlacemarkData?> getPlaceData(CameraPosition position)async {

    try { 
     double lat = position.target.latitude;
     double lng = position.target.longitude;
     List<Placemark> placeMarksList = await placemarkFromCoordinates(lat, lng);
   
     if(placeMarksList!=null && placeMarksList.isNotEmpty){
      if(placeMarksList.length>0){
        Placemark place = placeMarksList[0];
        String address = " ${place.street}, ${place.subAdministrativeArea} ${place.country}, ${place.administrativeArea}";
        PlacemarkData placemarkData = PlacemarkData(address: address, lat: lat, lng: lng);
        return placemarkData;
      }
     }
    } catch (e) {
      print('error getPlaceData: $e');
     return null;
    }

  }
  
  // función para obtener las coordenadas de la polilínea entre dos puntos
  @override
Future<List<LatLng>> getPolylineCoordinates(LatLng lugarRecogida, LatLng lugarDestino) async {
  // Lista donde se almacenarán las coordenadas de la ruta
  List<LatLng> polylineCoordinates = [];

  try {
    // Solicitud a la API de Google Directions para obtener la ruta
    final result = await PolylinePoints(apiKey: Apiconfig.ApiGoogleMap).getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(lugarRecogida.latitude, lugarRecogida.longitude),
        destination: PointLatLng(lugarDestino.latitude, lugarDestino.longitude),
        travelMode: TravelMode.driving, // 🚗 puedes cambiarlo: walking, bicycling, transit
      ),
    );

    // Validamos si la respuesta contiene puntos de la ruta
    if (result.primaryRoute?.polylinePoints case List<PointLatLng> points) {
      for (var point in points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      // Retornamos la lista de puntos de la ruta
      return polylineCoordinates;
    } else {
      // Lanzamos una excepción si no se encuentra una ruta válida
      throw Exception(result.errorMessage ?? 'No se encontró una ruta válida.');
    }
  } catch (e) {
    // En caso de error (por ejemplo, problemas con la conexión o API)
    throw Exception('Error obteniendo la ruta: $e');
  }
}

}
