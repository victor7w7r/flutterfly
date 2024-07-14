import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart' show Box, HiveInterface;
import 'package:mocktail/mocktail.dart' show Mock, when;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutterfly/core/modules/localdb_module.dart';
import '../../setup.dart';

final class MockBox<T> extends Mock implements Box<T> {}

final class MockHive extends Mock implements HiveInterface {}

void main() {
  late LocalDbModule localDbModule;

  group('LocalDbModule', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = MockPathProviderPlatform();
    });

    setUp(() => localDbModule = LocalDbModule());

    test('check init method', () async {
      await localDbModule.init();
      expect(localDbModule.prefsBox, isA<Box<bool>>());
    });

    test('check isMaterialDark method', () async {
      final box = MockBox<bool>();

      localDbModule.assignPrefsBox(box);
      when(() => box.get('materialdark')).thenReturn(true);

      expect(localDbModule.isMaterialDark(), true);
    });

    test('check isCupertinoDark method', () async {
      final box = MockBox<bool>();

      localDbModule.assignPrefsBox(box);
      when(() => box.get('cupertinodark')).thenReturn(true);

      expect(localDbModule.isCupertinoDark(), true);
    });

    test('check isFluentDark method', () async {
      final box = MockBox<bool>();

      localDbModule.assignPrefsBox(box);
      when(() => box.get('fluentdark')).thenReturn(true);

      expect(localDbModule.isFluentDark(), true);
    });

    test('check isMaterialDark method when the key is null', () async {
      final box = MockBox<bool>();

      when(() => box.put('materialdark', true))
          .thenAnswer((final _) async => Future<void>.value());
      localDbModule.assignPrefsBox(box);
      when(() => box.get('materialdark')).thenReturn(null);

      expect(localDbModule.isMaterialDark(), true);
    });
  });
}
