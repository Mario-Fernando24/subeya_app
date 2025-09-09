import 'package:flutter/cupertino.dart';
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/utils/Resource.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:subeya/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  final formKey = GlobalKey<FormState>();
  LoginUseCase loginUseCase = LoginUseCase();

  LoginBloc() : super(LoginState()) {
    on<LoginInitEvent>((event, emit) {
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

    on<FormSubmit>((event, emit) async {
      emit(state.copyWith(response: Loading(), formkey: formKey));

      Resource response = await loginUseCase.run(
        state.email.value,
        state.password.value,
      );

      emit(state.copyWith(response: response, formkey: formKey));
    });
  }
}
