import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

abstract class  ProfileUpdateEvent {}

class ProfileUpdateInitEvent extends ProfileUpdateEvent{
   
  final User? user;
  ProfileUpdateInitEvent({required this.user});

}

class NameChanged extends ProfileUpdateEvent{
  BlocFormItem name;
  NameChanged({ required this.name });
}

class LastnameChanged extends ProfileUpdateEvent{
  BlocFormItem lastname;
  LastnameChanged({ required this.lastname });
}


class PhoneChanged extends ProfileUpdateEvent{
  BlocFormItem phone;
  PhoneChanged({ required this.phone });
}

class FormUpdateSubmit extends ProfileUpdateEvent{}


