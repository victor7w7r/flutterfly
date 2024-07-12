import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/modules/localdb_module.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

class MockLocalDbModule extends Mock implements LocalDbModule {}

class MockBox extends Mock implements Box<bool> {}

void main() {
  group('FluentService', () {
    late FluentService fluentService;
    late MockLocalDbModule mockLocalDbModule;
    late Box<bool> mockBox;

    setUp(() async {
      mockLocalDbModule = MockLocalDbModule();
      mockBox = MockBox();
      when(mockLocalDbModule.prefsBox).thenAnswer((final _) => mockBox);
      when(() => mockBox.put('fluentdark', true))
          .thenAnswer((final _) async => Future<void>.value());
      when(() => mockBox.put('fluentdark', false))
          .thenAnswer((final _) async => Future<void>.value());
      mockLocalDbModule.assignPrefsBox(mockBox);
    });

    test('Should call mutate', () {
      when(mockLocalDbModule.isFluentDark).thenReturn(true);
      fluentService = FluentService(mockLocalDbModule);
      final theme = FluentThemeApp.dark();
      fluentService.mutate = theme;

      expect(fluentService.state(), theme);
    });

    test('Should call interpolator', () {
      when(mockLocalDbModule.isFluentDark).thenReturn(true);
      fluentService = FluentService(mockLocalDbModule)
        ..interpolator(darkColors);

      expect(fluentService.state().isDark, true);
    });

    test('Should call interpolator and await the timer', () async {
      when(mockLocalDbModule.isFluentDark).thenReturn(false);
      fluentService = FluentService(mockLocalDbModule)
        ..interpolator(lightColors);

      await Future<void>.delayed(const Duration(seconds: 1));

      expect(fluentService.state().isDark, false);
    });

    test('Should call toggle to dark', () async {
      when(mockLocalDbModule.isFluentDark).thenReturn(true);
      fluentService = FluentService(mockLocalDbModule);

      await fluentService.toggle(true);

      expect(fluentService.state().isDark, true);
      verify(mockLocalDbModule.prefsBox).called(1);
    });

    test('Should call toggle to light', () async {
      when(mockLocalDbModule.isFluentDark).thenReturn(false);
      fluentService = FluentService(mockLocalDbModule);

      await fluentService.toggle(false);

      expect(fluentService.state().isDark, false);
      verify(mockLocalDbModule.prefsBox).called(1);
    });
  });
}
