import 'package:get_it/get_it.dart' show GetIt;
import 'package:injectable/injectable.dart' show InjectableInit;

import 'locator.config.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> setup() async => await locator.init();