abstract class Loginevent {}

class EmailChanged extends Loginevent{

  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends Loginevent{

  final String password;
  PasswordChanged({required this.password});
}