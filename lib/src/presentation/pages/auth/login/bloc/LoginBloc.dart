import 'package:flutter/cupertino.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  Authusecases authusecases;
  final formKey = GlobalKey<FormState>();

  LoginBloc(this.authusecases) : super(LoginState())  {

    on<LoginInitEvent>((event, emit) async {
      
      AuthResponse? response =  await authusecases.getUseSessionUseCase.run();

      print(  "AuthResponse en session Mario : ${response!.toJson()}");
            print(  "AuthResponse en session Mario : ${response.user!.lastname}");

      emit(state.copyWith(formkey: formKey));
    });

    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isEmpty ? 'Ingresa el email' : null,
          ),
          formkey: formKey,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: BlocFormItem(
            value: event.password.value,
            error:
                event.password.value.isEmpty
                    ? 'Ingresa una contraseña'
                    : event.password.value.length < 4
                    ? 'Minimo 4 caracteres'
                    : null,
          ),
          formkey: formKey,
        ),
      );
    });
    
    //guardar la sesion del usuario
    on<SaveUserSession>((event, emit) async {
      await authusecases.saveUseSessionUseCase.run(event.authResponse);
    });

    on<FormSubmit>((event, emit) async {
      emit(state.copyWith(response: Loading(), formkey: formKey));

      Resource response = await authusecases.loginUseCase.run(
        state.email.value,
        state.password.value,
      );

      emit(state.copyWith(response: response, formkey: formKey));
    });
  }
}
