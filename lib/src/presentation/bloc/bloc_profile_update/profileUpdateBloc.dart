import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/domain/useCases/users/UsersUseCase.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_update/profileUpdateState.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {

  //inyectar casos de uso
  UsersUseCase usersUseCase;
  final formkeyUpdate = GlobalKey<FormState>();

  ProfileUpdateBloc(this.usersUseCase) : super(ProfileUpdateState()) {

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
