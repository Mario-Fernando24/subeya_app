import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:subeya/src/presentation/bloc/bloc_login/LoginBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginState.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/RegisterUseCases.dart';
import 'package:subeya/src/domain/useCases/auth/SaveUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/GetUseSessionUseCase.dart';
import 'package:subeya/src/domain/useCases/auth/LogoutUseSessionUseCase.dart';
import 'package:subeya/src/domain/models/auth_response.dart';
import 'package:subeya/src/domain/utils/Resource.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}
class _MockRegisterUseCases extends Mock implements Registerusecases {}
class _MockSaveUseSessionUseCase extends Mock implements SaveUseSessionUseCase {}
class _MockGetUseSessionUseCase extends Mock implements GetUseSessionUseCase {}
class _MockLogoutUseSessionUseCase extends Mock implements LogoutUseSesssionUseCase {}

void main() {
  late _MockLoginUseCase loginUC;
  late _MockRegisterUseCases registerUC;
  late _MockSaveUseSessionUseCase saveUC;
  late _MockGetUseSessionUseCase getUC;
  late _MockLogoutUseSessionUseCase logoutUC;
  late Authusecases ucs;

  setUp(() {
    loginUC = _MockLoginUseCase();
    registerUC = _MockRegisterUseCases();
    saveUC = _MockSaveUseSessionUseCase();
    getUC = _MockGetUseSessionUseCase();
    logoutUC = _MockLogoutUseSessionUseCase();
    ucs = Authusecases(
      loginUseCase: loginUC,
      registerUseCase: registerUC,
      saveUseSessionUseCase: saveUC,
      getUseSessionUseCase: getUC,
      logoutUseSesssionUseCase: logoutUC,
    );
  });

  blocTest<LoginBloc, LoginState>(
    'FormSubmit → Loading → Success',
    build: () => LoginBloc(ucs),
    setUp: () {
      when(() => loginUC.run('ok@mail.com', '1234')).thenAnswer(
        (_) async => Success(AuthResponse(accessToken: 'tok')),
      );
    },
    act: (b) {
      b.add(EmailChanged(email: const BlocFormItem(value: 'ok@mail.com')));
      b.add(PasswordChanged(password: const BlocFormItem(value: '1234')));
      b.add(FormSubmit());
    },
    expect: () => [
      isA<LoginState>(), // email
      isA<LoginState>(), // password
      isA<LoginState>().having((s) => s.response, 'Loading', isA<Loading>()),
      isA<LoginState>().having((s) => s.response, 'Success', isA<Success<AuthResponse>>()),
    ],
    verify: (_) => verify(() => loginUC.run('ok@mail.com', '1234')).called(1),
  );

  blocTest<LoginBloc, LoginState>(
    'FormSubmit → Loading → ErrorData',
    build: () => LoginBloc(ucs),
    setUp: () {
      when(() => loginUC.run('bad@mail.com', '0000')).thenAnswer(
        (_) async => ErrorData('Credenciales inválidas'),
      );
    },
    act: (b) {
      b.add(EmailChanged(email: const BlocFormItem(value: 'bad@mail.com')));
      b.add(PasswordChanged(password: const BlocFormItem(value: '0000')));
      b.add(FormSubmit());
    },
    expect: () => [
      isA<LoginState>(),
      isA<LoginState>(),
      isA<LoginState>().having((s) => s.response, 'Loading', isA<Loading>()),
      isA<LoginState>().having((s) => s.response, 'Error', isA<ErrorData>()),
    ],
  );
}
