// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:subeya/src/data/dataSource/remote/services/AuthServices.dart'
    as _i382;
import 'package:subeya/src/di/AppModule.dart' as _i958;
import 'package:subeya/src/domain/repository/AuthRepository.dart' as _i594;
import 'package:subeya/src/domain/useCases/auth/AuthUseCases.dart' as _i161;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i382.Authservices>(() => appModule.authservices);
    gh.factory<_i594.Authrepository>(() => appModule.authrepository);
    gh.factory<_i161.Authusecases>(() => appModule.authusecases);
    return this;
  }
}

class _$AppModule extends _i958.AppModule {}
