import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeState.dart';

class ClientHomeBloc extends Bloc<ClientHomeEvent, ClientHomeState>{

    Authusecases authusecases;


  ClientHomeBloc(this.authusecases): super (ClientHomeState()) {
    
    on<ChangeDrawerIndex>((event, emit) {
      emit(state.copyWith(pageIndex: event.index));
    });

    on<Logout>((event, emit)  async{
            await authusecases.logoutUseSesssionUseCase.run();

    });
    

  } 
}