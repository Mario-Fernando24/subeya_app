import 'package:flutter/material.dart';
import 'package:subeya/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:subeya/src/presentation/pages/auth/register/RegisterPage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'taxi subeya',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)
      ),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) =>LoginPage(),
        'register': (BuildContext context) =>RegisterPage(),
      },
    );
  }
}