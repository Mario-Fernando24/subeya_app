import 'package:flutter/material.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final formkeRegister = GlobalKey<FormState>();

  RegisterBloc() : super(RegisterState()) {

    on<RegisterInitEvent>((event, emit) {
      emit(state.copyWith(formkeRegister: formkeRegister));
    });

     on<NameChangedTextField>((event, emit) {
        emit(state.copyWith(
          name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isEmpty ? 'Ingresa nombre completo': null
          ),
          formkeRegister: formkeRegister
        ));
    });

    on<LastnameChangedTextField>((event, emit) {
        emit(state.copyWith(
          lastname: BlocFormItem(
            value: event.lastname.value,
            error: event.lastname.value.isEmpty ? 'Ingresa apellido completo': null
          ),
          formkeRegister: formkeRegister
        ));
    });

     on<EmailChangedTextField>((event, emit) {
        emit(state.copyWith(
          email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isEmpty ?
            'Ingresa correo electronico':
            event.email.value.length<6?
            'Mas de 6 caracteres': null
          ),

          formkeRegister: formkeRegister
        ));
    });

    on<PhoneChangedTextField>((event, emit) {
        emit(state.copyWith(
          phone: BlocFormItem(
            value: event.phone.value,
            error: event.phone.value.isEmpty ? 'Ingrese el telefono': event.phone.value.length<10? 'El numero de telefono debe ser de 10 digitos' : null
          ),
          formkeRegister: formkeRegister
        ));
    });

     on<PasswordChangedTextField>((event, emit) {
        emit(state.copyWith(
          password: BlocFormItem(
            value: event.password.value,
            error: event.password.value.isEmpty ? 'Contraseño no puede estar vacia': null
          ),
          formkeRegister: formkeRegister
        ));
    });

    

      on<ConfirmPasswordChangedTextField>((event, emit) {
        emit(state.copyWith(
          confirmPassword: BlocFormItem(
            value: event.confirmPassword.value,
            error: event.confirmPassword.value.isEmpty ? 'Confirma la contraseña'
            : event.confirmPassword.value.length<6
            ? 'La contraseña debe ser mayor a 6 caracteres' 
            : event.confirmPassword.value != state.password.value
            ?  'Las contraseñas no coinciden'
            : null
          ),
          formkeRegister: formkeRegister
        ));
    });



    on<FormRegisterSubmit>((event, emit) {
      print('Nombre: ${state.name.value}');
      print('Apellido: ${state.lastname.value}');
      print('Email: ${state.email.value}');
      print('Telefono: ${state.phone.value}');
      print('Password: ${state.password.value}');
      print('Confirmar: ${state.confirmPassword.value}');

    });

    on<FormResetSubmit>((event, emit) {
      print('reseteando los campos');
    });


  }
}
