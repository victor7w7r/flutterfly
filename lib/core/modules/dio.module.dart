import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/env.module.dart';

part 'dio.module.g.dart';

final class DioModule {

  DioModule(this._env): _client = Dio(BaseOptions(
    baseUrl: '${_env.protocol}://${_env.host}',
    headers: {
      'Content-Type': 'application/json'
    }
  ));

  final Dio _client;
  // ignore: unused_field
  final EnvModule _env;


  Dio get client => _client;

}

@Riverpod(keepAlive: true)
DioModule dioModule(
  final DioModuleRef ref
) => DioModule(ref.watch(envModule$));
