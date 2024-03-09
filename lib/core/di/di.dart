import 'package:get_it/get_it.dart' show GetIt;
import 'package:injectable/injectable.dart' show InjectableInit;

// ignore: always_use_package_imports
import 'di.config.dart';

final inject = GetIt.instance;

@InjectableInit()
Future<void> configInjection() => inject.init();
