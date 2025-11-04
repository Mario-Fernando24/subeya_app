import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subeya/blocProviders.dart';
import 'package:subeya/injection.dart';
import 'package:subeya/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:subeya/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:subeya/src/presentation/pages/client/mapaReservaInfo/clientMapReservaInfoPage.dart';
import 'package:subeya/src/presentation/pages/driver/home/DriveHomePage.dart';
import 'package:subeya/src/presentation/pages/profile/update_profile/profile_update_page.dart';
import 'package:subeya/src/presentation/pages/roles/rolesItems.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        // FToastBuilder sirves para mostrar toasts personalizados en la aplicación 
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'taxi subeya',
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        ),
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'client/home': (BuildContext context) => Clienthomepage(),
          'profile/update': (BuildContext context) => ProfileUpdatePage(),
          'client/mapaReservado': (BuildContext context) => ClientMapReservaInfopage(),
          //rutas conductor
          'driver/home': (BuildContext context) => DriveHomePage(),
          'screem/roles': (BuildContext context) => Rolesitems(),

        },
      ),
    );
  }
}
