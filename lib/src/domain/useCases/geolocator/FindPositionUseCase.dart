import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';

class FindPositionUsecase {

   GeolocatorRepository geolocatorRepository;

   FindPositionUsecase(this.geolocatorRepository);

    run()=> geolocatorRepository.findPosition();

}