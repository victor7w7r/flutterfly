// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutterfly/config/app_config.dart' as _i3;
import 'package:flutterfly/modules/common/repository/binance_repository.dart'
    as _i4;
import 'package:flutterfly/modules/common/repository/data/binance_data.dart'
    as _i5;
import 'package:flutterfly/modules/common/services/binance_service.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await gh.singletonAsync<_i3.AppConfig>(
      () => _i3.AppConfig.init(),
      preResolve: true,
    );
    gh.factory<_i4.BinanceRepository>(() => _i5.BinanceData());
    gh.factory<_i6.BinanceService>(
        () => _i6.BinanceService(gh<_i4.BinanceRepository>()));
    return this;
  }
}
