import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateState.dart';
import 'package:subeya/src/presentation/pages/profile/update_profile/profile_update_content.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // esperar a que se renderice la pantalla
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileUpdateBloc>().add(ProfileUpdateInitEvent(user: user));
    });
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          final response = state.response;

          if(response is ErrorData){
             Fluttertoast.showToast(
              msg: response.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }else if(response is Success){
            
             Fluttertoast.showToast(
              msg: 'Usuario actualizado correctamente',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
            );
            
            print('______________________Pantalla principal_____________________________________');
            print(response.data.toJson());
            print('_______________________Pantalla principal____________________________________');
             final authresponse = response.data as AuthResponse;
             context.read<ProfileUpdateBloc>().add(UpdateUserSession(user: authresponse.user!));
             context.read<ProfileInfoBloc>().add(GetUserInfo());
            Navigator.pushNamed(context, 'client/home');
          }
        },
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          builder: (context, state) {
            final response = state.response;
            if(response is Loading){
              return Stack(
                children: [
                  ProfileUpdateContent(user, state),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],  
              );
            }
            return ProfileUpdateContent(user, state);
          },
        ),
      ),
    );
  }
}
