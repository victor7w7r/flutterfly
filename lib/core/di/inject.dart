// ignore_for_file: always_use_package_imports
// coverage:ignore-file

import 'package:get_it/get_it.dart' show GetIt;
import 'package:injectable/injectable.dart' show InjectableInit;

import 'inject.config.dart';

@InjectableInit()
Future<void> configInjection() => GetIt.I.init();
