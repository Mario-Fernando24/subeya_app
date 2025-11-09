import 'package:subeya/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPlaceMarkDataUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPolylinePointsUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPositionsStreamsUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/getMarkerUseCase.dart';

class GeolocatorUseCase {

  FindPositionUsecase findPositionUsecase;
  CreatemarketUsecase createmarketUsecase;
  GetMarkerUsecase getMarkerUsecase;
  GetplacemarkDataUsecase getplacemarkDataUsecase;
  GetPolylinePointsUsecase getPolylinePointsUsecase;
  GetPositionsStreamsUsecase getPositionsStreamsUsecase;

   GeolocatorUseCase({
    required this.findPositionUsecase,
    required this.createmarketUsecase,
    required this.getMarkerUsecase,
    required this.getplacemarkDataUsecase,
    required this.getPolylinePointsUsecase,
    required this.getPositionsStreamsUsecase,
   });

}