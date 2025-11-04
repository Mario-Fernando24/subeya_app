import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_drivers_home/DriversHomeEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_drivers_home/DriversHomeState.dart';

class DriversHomeBloc extends Bloc<DriversHomeEvent, DriversHomeState>{

    Authusecases authusecases;


  DriversHomeBloc(this.authusecases): super (DriversHomeState()) {
    
    on<ChangeDrawerIndex>((event, emit) {
      emit(state.copyWith(pageIndex: event.index));
    });

    on<Logout>((event, emit)  async{
            await authusecases.logoutUseSesssionUseCase.run();

    });
    

  } 
}