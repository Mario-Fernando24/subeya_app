import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoState.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {

  //inyectar casos de uso
    Authusecases authusecases;


    ProfileInfoBloc(this.authusecases) : super(ProfileInfoState())  {
      on<GetUserInfo>((event, emit) async {
        //llamar al caso de uso para obtener la informacion del usuario
        //y emitir el estado con la informacion obtenida
         AuthResponse? response  =  await authusecases.getUseSessionUseCase.run();
         print("+++++++++++++++++ProfileInfoBloc+++++++++++++++++++++++++++++++++++");
          print(response!.toJson());
         print("++++++++++++++++ProfileInfoBloc++++++++++++++++++++++++++++++++++++");
         emit(state.copyWith(user: response.user));
      });
  
    }


}