import 'dart:async' show unawaited;

import 'package:flutter/widgets.dart';

import 'package:fl_query/fl_query.dart' show QueryClient;
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocalDbModule {
  late final Box<bool> _prefsBox;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await Hive.initFlutter();
    await QueryClient.initialize(cachePrefix: 'flutterfly');
    _prefsBox = await Hive.openBox<bool>('prefsBox');
  }

  @visibleForTesting
  // ignore: use_setters_to_change_properties
  void assignPrefsBox(final Box<bool> box) => _prefsBox = box;

  bool _isDarkWorker(final String key) {
    final isDark = _prefsBox.get(key);
    if (isDark == null) {
      unawaited(_prefsBox.put(key, true));
      return true;
    } else {
      return isDark;
    }
  }

  Box<bool> prefsBox() => _prefsBox;

  bool isMaterialDark() => _isDarkWorker('materialdark');
  bool isCupertinoDark() => _isDarkWorker('cupertinodark');
  bool isFluentDark() => _isDarkWorker('fluentdark');
}
