import 'package:subeya/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPlaceMarkDataUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/getMarkerUseCase.dart';

class GeolocatorUseCase {

  FindPositionUsecase findPositionUsecase;
  CreatemarketUsecase createmarketUsecase;
  GetMarkerUsecase getMarkerUsecase;
  GetplacemarkDataUsecase getplacemarkDataUsecase;

   GeolocatorUseCase({
    required this.findPositionUsecase,
    required this.createmarketUsecase,
    required this.getMarkerUsecase,
    required this.getplacemarkDataUsecase,
   });

}