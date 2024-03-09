// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutterfly/core/modules/dio_module.dart' as _i14;
import 'package:flutterfly/core/modules/localdb_module.dart' as _i5;
import 'package:flutterfly/features/common/business/repositories/binance_repository.dart'
    as _i7;
import 'package:flutterfly/features/common/business/repositories/bitcoin_repository.dart'
    as _i9;
import 'package:flutterfly/features/common/business/repositories/repositories.dart'
    as _i12;
import 'package:flutterfly/features/common/business/usecases/get_bitcoin.dart'
    as _i11;
import 'package:flutterfly/features/common/business/usecases/get_currencies.dart'
    as _i13;
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart'
    as _i6;
import 'package:flutterfly/features/common/data/repositories/binance_repository_impl.dart'
    as _i8;
import 'package:flutterfly/features/common/data/repositories/bitcoin_repository_impl.dart'
    as _i10;
import 'package:flutterfly/features/common/ui/services/data_service.dart'
    as _i3;
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
    gh.lazySingleton<_i3.DataService>(() => _i3.DataService());
    gh.singleton<_i4.Dio>(() => dioModule.dio);
    await gh.singletonAsync<_i5.LocalDbModule>(
      () {
        final i = _i5.LocalDbModule();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<String>(
      () => dioModule.route,
      instanceName: 'route',
    );
    gh.factory<_i6.BinanceRemoteDataSource>(() => _i6.BinanceRemoteDataSource(
          gh<_i4.Dio>(),
          baseUrl: gh<String>(instanceName: 'route'),
        ));
    gh.factory<_i7.BinanceRepository>(
        () => _i8.BinanceRepositoryImpl(gh<_i6.BinanceRemoteDataSource>()));
    gh.factory<_i9.BitcoinRepository>(
        () => _i10.BitcoinRepositoryImpl(gh<_i6.BinanceRemoteDataSource>()));
    gh.factory<_i11.GetBitcoinUseCase>(
        () => _i11.GetBitcoinUseCase(gh<_i12.BitcoinRepository>()));
    gh.factory<_i13.GetCurrenciesUseCase>(
        () => _i13.GetCurrenciesUseCase(gh<_i12.BinanceRepository>()));
    return this;
  }
}

class _$DioModule extends _i14.DioModule {}
