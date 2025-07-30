import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class LoginState extends Equatable {

  final BlocFormItem email;
  final BlocFormItem password;
   //controlar el formulario
  final GlobalKey<FormState>? formkey;

  //contructor
  const LoginState({
    this.email = const BlocFormItem(error: 'Ingresa el email'),
    this.password = const BlocFormItem(error: 'Ingresa la contraseña'),
    this.formkey
  });

  LoginState copyWith({
     BlocFormItem? email,
     BlocFormItem? password,
     GlobalKey<FormState>? formkey,
  }){
     return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formkey: formkey
     );
  }

  //las variables que van a cambiar de estados
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];

}