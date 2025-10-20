import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/injection.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/useCases/geolocator/GeolocatorUseCase.dart';
import 'package:subeya/src/domain/useCases/users/UsersUseCase.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_register/RegisterBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_register/RegisterEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_client_home/ClientHomeBloc.dart';

List<BlocProvider> blocProviders = [
   
   BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<Authusecases>())..add(LoginInitEvent())),
   BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<Authusecases>())..add(RegisterInitEvent())),
   BlocProvider<ClientHomeBloc>(create: (context) => ClientHomeBloc(locator<Authusecases>())),
   BlocProvider<ProfileInfoBloc>(create: (context) => ProfileInfoBloc(locator<Authusecases>())),
   BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc(locator<UsersUseCase>(), locator<Authusecases>())),
   BlocProvider<ClientMapaBloc>(create: (context) => ClientMapaBloc(locator<GeolocatorUseCase>())..add(FindPosition())),

];