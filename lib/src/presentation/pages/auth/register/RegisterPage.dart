import 'package:flutter/material.dart';
import 'package:subeya/src/presentation/pages/auth/register/RegisterContent.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: RegisterContent()
      );
  }
}