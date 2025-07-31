import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';

List<BlocProvider> blocProviders = [
   
   BlocProvider<LoginBloc>(create: (context) => LoginBloc()..add(LoginInitEvent())),
   BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()..add(RegisterInitEvent())),

];