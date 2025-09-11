import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:subeya/injection.config.dart';

final locator = GetIt.instance;

// nos va a permitir inicializar la inyeccion de dependencias
@InjectableInit()
Future<void> configureDependencies() async {
  await locator.init();
  // await $initGetIt(locator);
}