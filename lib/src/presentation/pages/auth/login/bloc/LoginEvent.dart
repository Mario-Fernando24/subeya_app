import 'package:subeya/src/presentation/utils/blocFormItem.dart';

abstract class LoginEvent {}

class LoginInitEvent extends LoginEvent{}

class EmailChanged extends LoginEvent{

  final BlocFormItem email;
  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent{

  final BlocFormItem password;
  PasswordChanged({required this.password});
}

class FormSubmit extends LoginEvent{}