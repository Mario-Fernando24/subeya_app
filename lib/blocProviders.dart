import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/injection.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';

List<BlocProvider> blocProviders = [
   
   BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<Authusecases>())..add(LoginInitEvent())),
   BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<Authusecases>())..add(RegisterInitEvent())),
   BlocProvider<ClientHomeBloc>(create: (context) => ClientHomeBloc()),

];