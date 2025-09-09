import 'package:flutter/material.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginState.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final response = state.response;
          if(response is ErrorData){
            final message = response.message;
            print("***************************************");
            print('ERRORRRR'+message);
            print("***************************************");
          }else  if(response is Success){
            print("***************************************");
            print('SUCCESS'+response.data.toString());
            print("***************************************");
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final response = state.response;
            if(response is Loading){
              return Stack(
                children: [
                  LoginContent(state),
                  Center(child: CircularProgressIndicator())
               ],
              );
            }
            return LoginContent(state);
          },
        ),
      ),
    );
  }
}
