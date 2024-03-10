import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutterfly/core/constants/constants.dart';

@module
abstract class DioModule {
  @Named('route')
  String get route => '';

  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: '$protocol://$host',
          headers: {'Content-Type': 'application/json'},
        ),
      );
}
