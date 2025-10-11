import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoState.dart';
import 'package:subeya/src/presentation/pages/profile/info/profileInfoContent.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
        builder: (context, state) {
          return ProfileInfoContent(state.user);
        },
      )
    );
  }
}
