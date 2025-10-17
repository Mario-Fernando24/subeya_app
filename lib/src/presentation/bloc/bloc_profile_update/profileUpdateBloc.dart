import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/useCases/users/UsersUseCase.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateState.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {

  //inyectar casos de uso
  UsersUseCase usersUseCase;
  Authusecases authusecases;
  final formkeyUpdate = GlobalKey<FormState>();

  ProfileUpdateBloc(this.usersUseCase, this.authusecases) : super(ProfileUpdateState()) {

    on<ProfileUpdateInitEvent>((event, emit) {
      emit(
        state.copyWith(
        id: event.user?.id ?? 0,
        name: BlocFormItem(value: event.user?.name ?? ''),
        lastname: BlocFormItem(value: event.user?.lastname ?? ''),
        phone: BlocFormItem(value: event.user?.phone ?? ''),
        formKeyUpdate: formkeyUpdate,
        response: Initial()
      ));
    });

    on<NameChanged>((event, emit) {
      emit(
        state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isEmpty ? 'Ingresa nombre completo' : null,
        ),
        formKeyUpdate: formkeyUpdate,
      ));
    });

    on<LastnameChanged>((event, emit) {
      emit(state.copyWith(
        lastname: BlocFormItem(
          value: event.lastname.value,
          error: event.lastname.value.isEmpty ? 'Ingresa apellido completo' : null,
        ),
        formKeyUpdate: formkeyUpdate,
      ));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isEmpty ? 'Ingresa el Telefono' : null,
        ),
        formKeyUpdate: formkeyUpdate,
      ));
    });

    on<UpdateUserSession>((event, emit) async {

      AuthResponse response = await authusecases.getUseSessionUseCase.run();
      response.user!.name = event.user.name;
      response.user!.lastname = event.user.lastname;
      response.user!.phone = event.user.phone;
      response.user!.image = event.user.image;
      await authusecases.saveUseSessionUseCase.run(response);

    });

    on<PickImage>((event, emit) async {
      // Lógica para seleccionar una imagen de la galería
      print('Seleccionar imagen de la galería');
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print('Imagen seleccionada: ${image.path}');
        emit(state.copyWith(
          imageFile: File(image.path),
          formKeyUpdate: formkeyUpdate
        ));
      } else {
        print('No se seleccionó ninguna imagen.');
      }
    });

    on<TakePhoto>((event, emit) async {
      // Lógica para tomar una foto con la cámara
      print('Tomar foto con la cámara');
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        print('Foto tomada: ${photo.path}');
        emit(state.copyWith(
          imageFile: File(photo.path),
          formKeyUpdate: formkeyUpdate
        ));
      } else {
        print('No se tomó ninguna foto.');
      }
    });

    on<FormUpdateSubmit>((event, emit) async {

      if (state.formKeyUpdate!.currentState!.validate()) {
        
        // Aquí puedes manejar el envío del formulario
        print(state.name.value);
        print(state.lastname.value);
        print(state.phone.value);
        emit(state.copyWith(
          response: Loading()
        ));

      final user = User(
        id: state.id,
        name: state.name.value,
        lastname: state.lastname.value,
        phone: state.phone.value,
      );

        final response = await usersUseCase.updateUserUseCase.run(
          state.id,
          user,
          null,
        );

        print('Respuesta del update: '+response.toString());
        emit(state.copyWith(
          response: response,
          formKeyUpdate: formkeyUpdate
        ));
     
      
      } else {
        print('Formulario inválido. Corrige los errores.');
      }
    });

    

   
  }

}
