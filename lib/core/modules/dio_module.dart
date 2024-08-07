import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutterfly/core/constants/constants.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: '$protocol://$host',
          headers: {'Content-Type': 'application/json'},
        ),
      );

  @Named('route')
  String get route => '';
}
