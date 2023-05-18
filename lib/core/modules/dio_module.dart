import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' show singleton;

import 'package:flutterfly/core/modules/env_module.dart';
import 'package:flutterfly/core/utils/platforms.dart';

@singleton
final class DioModule {

  final Dio _client;

  // ignore: unused_field
  final EnvModule _env;

  DioModule(this._env): _client = Dio(BaseOptions(
    baseUrl: '${_env.protocol}://${_env.host}',
    responseType: ResponseType.json,
    headers: {
      'Content-Type': 'application/json'
    },
    connectTimeout: !isWeb
      ? const Duration(milliseconds: 3000)
      : null
  ));

  Dio get client => _client;

}