import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:subeya/src/data/api/ApiConfig.dart';
import 'package:subeya/src/data/dataSource/local/sharefPref.dart';
import 'package:subeya/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:subeya/src/data/dataSource/remote/services/UserService.dart';
import 'package:subeya/src/data/repository/AuthRepositoryImp.dart';
import 'package:subeya/src/data/repository/GeolocartorRepositoryImpl.dart';
import 'package:subeya/src/data/repository/SocketRepositoryImp.dart';
import 'package:subeya/src/data/repository/UserRepositoryImp.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/repository/AuthRepository.dart';
import 'package:subeya/src/domain/repository/GeolocatorRepository.dart';
import 'package:subeya/src/domain/repository/SocketRepository.dart';
import 'package:subeya/src/domain/repository/UserRepository.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/LogoutUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/GetUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/RegisterUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/SaveUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPlaceMarkDataUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPolylinePointsUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/GetPositionsStreamsUseCase.dart';
import 'package:subeya/src/domain/useCases/geolocator/getMarkerUseCase.dart';
import 'package:subeya/src/domain/useCases/socket/connectSocketUseCase.dart';
import 'package:subeya/src/domain/useCases/socket/disconnecSocketUseCase.dart';
import 'package:subeya/src/domain/useCases/socket/socketUseCase.dart';
import 'package:subeya/src/domain/useCases/users/UpdateUserUseCase.dart';
import 'package:subeya/src/domain/useCases/users/UsersUseCase.dart';

@module
abstract class AppModule {

  @injectable
  Sharefpref get sharefpref => Sharefpref();

  @injectable
  Socket get socket => io(Apiconfig.baseUrl,
    OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      .build()
  );


  @injectable
  Future<String> get token async {
    String token = '';
             AuthResponse? response  =  await authusecases.getUseSessionUseCase.run();

    if(response != null){
      AuthResponse authResponse = AuthResponse.fromJson(response.toJson());
      print(' TOKEN MARIO FERNANDO: ${authResponse.accessToken}');
      print(' TOKEN: ${authResponse.accessToken}');
       token = authResponse.accessToken ?? '';
       return token;
    }
    return token; 
  }
   
   @injectable 
  Authservices get authservices => Authservices();

  @injectable
  Userservice get userservice => Userservice(token);

  @injectable
  Authrepository get authrepository => Authrepositoryimp(authservices,sharefpref);

  @injectable
  UserRepository get userRepository => UserRepositoryImp(userservice);
  
  @injectable
  Socketrepository get sockerepostory => SocketRepositoryImp(socket);


  @injectable
  GeolocatorRepository get geolocatorRepository => Geolocartorrepositoryimpl();


  @injectable
  Authusecases get authusecases => Authusecases(
    loginUseCase: LoginUseCase(authrepository),
    registerUseCase: Registerusecases(authrepository),
    getUseSessionUseCase: GetUseSessionUseCase(authrepository:  authrepository),
    saveUseSessionUseCase: SaveUseSessionUseCase(authrepository: authrepository),
    logoutUseSesssionUseCase: LogoutUseSesssionUseCase(authrepository: authrepository),
  );  


  @injectable
  UsersUseCase get useCaseUse => UsersUseCase(
    updateUserUseCase: UpdateUserUseCase(userRepository),
  );  

  @injectable
  SocketUseCase get socketUse => SocketUseCase(
    connect: ConnectSocketUseCase(sockerepostory), 
    disconnect: DisconnectSocketUseCase(sockerepostory)
  );  

  @injectable
  GeolocatorUseCase get geolocatorUseCase => GeolocatorUseCase(
    findPositionUsecase: FindPositionUsecase(geolocatorRepository),
    createmarketUsecase: CreatemarketUsecase(geolocatorRepository),
    getMarkerUsecase: GetMarkerUsecase(geolocatorRepository),
    getplacemarkDataUsecase: GetplacemarkDataUsecase(geolocatorRepository),
    getPolylinePointsUsecase: GetPolylinePointsUsecase(geolocatorRepository),
    getPositionsStreamsUsecase: GetPositionsStreamsUsecase(geolocatorRepository)
  );  



}