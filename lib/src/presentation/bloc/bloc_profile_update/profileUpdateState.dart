import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateState extends Equatable {

  final  BlocFormItem name;
  final  BlocFormItem lastname;
  final  BlocFormItem phone;
  final GlobalKey<FormState>? formKeyUpdate;

   ProfileUpdateState({
      this.name = const BlocFormItem(error: 'Ingresa Nombre'),
      this.lastname = const BlocFormItem(error: 'Ingresa Apellido'),
      this.phone = const BlocFormItem(error: 'Ingresa el Telefono'),
      this.formKeyUpdate,
   });

    ProfileUpdateState copyWith({
      BlocFormItem? name,
      BlocFormItem? lastname,
      BlocFormItem? phone,
      GlobalKey<FormState>? formKeyUpdate,
   }){
      return ProfileUpdateState(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
        formKeyUpdate: formKeyUpdate ?? this.formKeyUpdate,
      );
   }


  @override
  List<Object?> get props => [name, lastname, phone, formKeyUpdate];

}

