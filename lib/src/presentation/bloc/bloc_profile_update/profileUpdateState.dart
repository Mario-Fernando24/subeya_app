import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateState extends Equatable {
  final int id;
  final  BlocFormItem name;
  final  BlocFormItem lastname;
  final  BlocFormItem phone;
  final File? imageFile;
  final GlobalKey<FormState>? formKeyUpdate;
  final Resource? response;


   ProfileUpdateState({
    this.id = 0,
      this.name = const BlocFormItem(error: 'Ingresa Nombre'),
      this.lastname = const BlocFormItem(error: 'Ingresa Apellido'),
      this.phone = const BlocFormItem(error: 'Ingresa el Telefono'),
      this.imageFile,
      this.formKeyUpdate,
      this.response,
   });


    ProfileUpdateState copyWith({
      int ? id,
      BlocFormItem? name,
      BlocFormItem? lastname,
      BlocFormItem? phone,
      File? imageFile,
      GlobalKey<FormState>? formKeyUpdate,
      Resource? response
   }){
      return ProfileUpdateState(
        id: id ?? this.id,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
        imageFile: imageFile ?? this.imageFile,
        formKeyUpdate: formKeyUpdate ?? this.formKeyUpdate,
        response: response ?? this.response
      );
   }


  @override
  List<Object?> get props => [id,name, lastname, phone, imageFile, formKeyUpdate,response];

}

