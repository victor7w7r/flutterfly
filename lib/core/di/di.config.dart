// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutterfly/core/modules/dio_module.dart' as _i6;
import 'package:flutterfly/core/modules/localdb_module.dart' as _i4;
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.singleton<_i3.Dio>(() => dioModule.dio);
    await gh.singletonAsync<_i4.LocalDbModule>(
      () {
        final i = _i4.LocalDbModule();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<String>(
      () => dioModule.route,
      instanceName: 'route',
    );
    gh.factory<_i5.BinanceRemoteDataSource>(() => _i5.BinanceRemoteDataSource(
          gh<_i3.Dio>(),
          baseUrl: gh<String>(instanceName: 'route'),
        ));
    return this;
  }
}

class _$DioModule extends _i6.DioModule {}
