import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginState extends Equatable {

  final String email;
  final String password;
   //controlar el formulario
  final GlobalKey<FormState>? formkey;

  //contructor
  const LoginState({
    this.email = '',
    this.password = '',
    this.formkey
  });

  LoginState copyWith({
     String? email,
     String? password,
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