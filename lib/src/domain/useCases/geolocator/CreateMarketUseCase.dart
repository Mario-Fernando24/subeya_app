import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';

class CreatemarketUsecase {

   GeolocatorRepository geolocatorRepository;

   CreatemarketUsecase(this.geolocatorRepository);

    run(String path)=> geolocatorRepository.createMarkerFromAsset(path);

}