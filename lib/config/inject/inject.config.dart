// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutterfly/core/modules/dio_module.dart' as _i5;
import 'package:flutterfly/core/modules/env_module.dart' as _i3;
import 'package:flutterfly/core/modules/shareprefs_module.dart' as _i4;
import 'package:flutterfly/features/common/domain/repository/binance_repository.dart'
    as _i6;
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
    gh.singleton<_i3.EnvModule>(_i3.EnvModule());
    await gh.factoryAsync<_i4.SharedPrefsModule>(
      () {
        final i = _i4.SharedPrefsModule();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.singleton<_i5.DioModule>(_i5.DioModule(gh<_i3.EnvModule>()));
    gh.factory<_i6.BinanceRepository>(
        () => _i6.BinanceRepository(gh<_i5.DioModule>()));
    return this;
  }
}
