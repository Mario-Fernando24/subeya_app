import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeState.dart';

class ClientHomeBloc extends Bloc<ClientHomeEvent, ClientHomeState>{

  ClientHomeBloc(): super (ClientHomeState()) {
    
    on<ChangeDrawerIndex>((event, emit) {
      emit(state.copyWith(pageIndex: event.index));
    });

  } 
}