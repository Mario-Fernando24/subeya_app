import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/pages/auth/register/RegisterContent.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterState.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          final response = state.response;
          
          if(response is Success){
            
            context.read<RegisterBloc>().add(FormResetSubmit());
            Navigator.pop(context);

          }else if(response is ErrorData){
              Fluttertoast.showToast(
              msg: response.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
            );
             Navigator.pop(context);

           
          } 
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return RegisterContent(state);
          },
        ),
      ),
    );
  }
}
