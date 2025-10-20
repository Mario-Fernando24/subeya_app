import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';


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
}
