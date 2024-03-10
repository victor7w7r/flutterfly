import 'dart:async' show unawaited;

import 'package:fl_query/fl_query.dart' show QueryClient;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
final class LocalDbModule {
  late final Box<bool> prefsBox;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await Hive.initFlutter();
    await QueryClient.initialize(cachePrefix: 'flutterfly');
    prefsBox = await Hive.openBox<bool>('prefsBox');
  }

  bool _darkWorker(final String key) {
    final isDark = prefsBox.get(key);
    if (isDark == null) {
      unawaited(prefsBox.put(key, true));
      return true;
    } else {
      return isDark;
    }
  }

  bool get materialDark => _darkWorker('materialdark');
  bool get cupertinoDark => _darkWorker('cupertinodark');
  bool get fluentDark => _darkWorker('fluentdark');
}
