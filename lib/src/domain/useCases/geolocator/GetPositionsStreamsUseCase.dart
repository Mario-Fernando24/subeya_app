import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';

class GetPositionsStreamsUsecase {

  GeolocatorRepository geolocatorRepository;

  GetPositionsStreamsUsecase(this.geolocatorRepository);

  run() => geolocatorRepository.getPositionStream();


}