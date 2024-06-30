// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'package:flutterfly/core/modules/dio_module.dart' as _i23;
import 'package:flutterfly/core/modules/localdb_module.dart' as _i4;
import 'package:flutterfly/core/utils/platforms.dart' as _i3;
import 'package:flutterfly/core/utils/utils.dart' as _i22;

import 'package:flutterfly/features/common/business/repositories/binance_repository.dart'
    as _i15;
import 'package:flutterfly/features/common/business/repositories/bitcoin_repository.dart'
    as _i13;
import 'package:flutterfly/features/common/business/repositories/repositories.dart'
    as _i18;
import 'package:flutterfly/features/common/business/usecases/get_bitcoin.dart'
    as _i17;
import 'package:flutterfly/features/common/business/usecases/get_currencies.dart'
    as _i19;
import 'package:flutterfly/features/common/business/usecases/usecases.dart'
    as _i21;
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart'
    as _i12;
import 'package:flutterfly/features/common/data/repositories/binance_repository_impl.dart'
    as _i16;
import 'package:flutterfly/features/common/data/repositories/bitcoin_repository_impl.dart'
    as _i14;
import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart'
    as _i8;
import 'package:flutterfly/features/common/ui/services/binance_service.dart'
    as _i20;
import 'package:flutterfly/features/common/ui/services/data_service.dart'
    as _i6;
import 'package:flutterfly/features/common/ui/services/desktop_service.dart'
    as _i7;
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart'
    as _i9;
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart'
    as _i10;
import 'package:flutterfly/features/material/ui/services/material_service.dart'
    as _i11;

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
    gh.factory<_i3.Platform>(() => _i3.Platform());
    await gh.singletonAsync<_i4.LocalDbModule>(
      () {
        final i = _i4.LocalDbModule();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.lazySingleton<_i5.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i6.DataService>(() => _i6.DataService());
    gh.lazySingleton<_i7.DesktopService>(() => _i7.DesktopService());
    gh.lazySingleton<_i8.DesktopSelectorController>(
        () => _i8.DesktopSelectorController(gh<_i7.DesktopService>()));
    gh.lazySingleton<_i9.CupertinoService>(
        () => _i9.CupertinoService(gh<_i4.LocalDbModule>()));
    gh.lazySingleton<_i10.FluentService>(
        () => _i10.FluentService(gh<_i4.LocalDbModule>()));
    gh.lazySingleton<_i11.MaterialService>(
        () => _i11.MaterialService(gh<_i4.LocalDbModule>()));
    gh.factory<String>(
      () => dioModule.route,
      instanceName: 'route',
    );
    gh.factory<_i12.BinanceRemoteDataSource>(() => _i12.BinanceRemoteDataSource(
          gh<_i5.Dio>(),
          baseUrl: gh<String>(instanceName: 'route'),
        ));
    gh.factory<_i13.BitcoinRepository>(
        () => _i14.BitcoinRepositoryImpl(gh<_i12.BinanceRemoteDataSource>()));
    gh.factory<_i15.BinanceRepository>(
        () => _i16.BinanceRepositoryImpl(gh<_i12.BinanceRemoteDataSource>()));
    gh.factory<_i17.GetBitcoinUseCase>(
        () => _i17.GetBitcoinUseCase(gh<_i18.BitcoinRepository>()));
    gh.factory<_i19.GetCurrenciesUseCase>(
        () => _i19.GetCurrenciesUseCase(gh<_i18.BinanceRepository>()));
    gh.lazySingleton<_i20.BinanceService>(() => _i20.BinanceService(
          gh<_i21.GetCurrenciesUseCase>(),
          gh<_i21.GetBitcoinUseCase>(),
          gh<_i22.Platform>(),
        ));
    return this;
  }
}

class _$DioModule extends _i23.DioModule {}
