import 'package:flutter/material.dart';
import 'package:subeya/src/presentation/pages/auth/login/LoginContent.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginContent(),
    );
  }
}