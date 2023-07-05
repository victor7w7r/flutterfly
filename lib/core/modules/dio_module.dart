import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/env_module.dart';

part 'dio_module.g.dart';

final class DioModule {

  final Dio _client;

  // ignore: unused_field
  final EnvModule _env;

  DioModule(this._env): _client = Dio(BaseOptions(
    baseUrl: '${_env.protocol}://${_env.host}',
    responseType: ResponseType.json,
    headers: {
      'Content-Type': 'application/json'
    }
  ));

  Dio get client => _client;

}

@Riverpod(keepAlive: true)
DioModule dioModule(
  final DioModuleRef ref
) => DioModule(ref.watch(envModule$));
