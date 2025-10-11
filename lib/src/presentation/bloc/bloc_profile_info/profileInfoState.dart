import 'package:equatable/equatable.dart';
import 'package:subeya/src/domain/models/user_model.dart';

class ProfileInfoState extends Equatable {

  final  User? user;

   ProfileInfoState({this.user});

   ProfileInfoState copyWith({
     User? user,
  }){
     return ProfileInfoState(
      user: user ?? this.user
     );
  }


  @override
  List<Object?> get props => [user];

}

