import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/modules/localdb_module.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class MockLocalDbModule extends Mock implements LocalDbModule {}

final class MockBox extends Mock implements Box<bool> {}

void main() {
  group('MaterialService', () {
    late MaterialService materialService;
    late MockLocalDbModule mockLocalDbModule;
    late Box<bool> mockBox;

    setUp(() async {
      mockLocalDbModule = MockLocalDbModule();
      mockBox = MockBox();
      when(mockLocalDbModule.isMaterialDark).thenReturn(false);
      when(() => mockLocalDbModule.prefsBox).thenAnswer((final _) => mockBox);
      when(() => mockBox.put('materialdark', true))
          .thenAnswer((final _) async => Future<void>.value());
      mockLocalDbModule.assignPrefsBox(mockBox);
      materialService = MaterialService(mockLocalDbModule);
    });

    test(
      'should initialize with the correct isDark value',
      () => expect(materialService.isDark, false),
    );

    test('toggle should invert isDark value', () async {
      expect(materialService.isDark, false);

      materialService.toggle();
      expect(materialService.isDark, true);

      reset(mockBox);

      verify(() => mockLocalDbModule.prefsBox).called(1);
    });

    test('should notify listeners when toggle is called', () {
      var isNotified = false;
      materialService
        ..addListener(() => isNotified = true)
        ..toggle();

      expect(isNotified, true);
    });
  });
}
