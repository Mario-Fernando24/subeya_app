import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';

abstract class RegisterEvent {}

class RegisterInitEvent extends RegisterEvent{}

class NameChangedTextField extends RegisterEvent{
  BlocFormItem name;
  NameChangedTextField({ required this.name });
}

class LastnameChangedTextField extends RegisterEvent{
  BlocFormItem lastname;
  LastnameChangedTextField({ required this.lastname });
}

class EmailChangedTextField extends RegisterEvent{
  BlocFormItem email;
  EmailChangedTextField({ required this.email });
}

class PhoneChangedTextField extends RegisterEvent{
  BlocFormItem phone;
  PhoneChangedTextField({ required this.phone });
}

class PasswordChangedTextField extends RegisterEvent{
  BlocFormItem password;
  PasswordChangedTextField({ required this.password });
}

class ConfirmPasswordChangedTextField extends RegisterEvent{
  BlocFormItem confirmPassword;
  ConfirmPasswordChangedTextField({ required this.confirmPassword });
}

class FormRegisterSubmit extends RegisterEvent{}

class SaveUserSession extends RegisterEvent{
    
    final AuthResponse authResponse;
    SaveUserSession({required this.authResponse});

}

class FormResetSubmit extends RegisterEvent{}


