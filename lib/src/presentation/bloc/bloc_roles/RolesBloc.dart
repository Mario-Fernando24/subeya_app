import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/presentation/bloc/bloc_roles/RolesEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_roles/RolesState.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState>{

  Authusecases authusecases;

  RolesBloc(this.authusecases): super (RolesState()) {
     
     on<GetRolesList>((event, emit) async {
        AuthResponse authResponse = await authusecases.getUseSessionUseCase.run();

        emit(state.copyWith(
          roles: authResponse.user?.roles
        ));
     });

  }

}