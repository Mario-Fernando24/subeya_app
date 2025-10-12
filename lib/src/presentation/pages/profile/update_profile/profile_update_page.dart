import 'package:flutter/material.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/presentation/pages/profile/update_profile/profile_update_content.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {

  User ? user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      body: ProfileUpdateContent(user)
    );
  }
}