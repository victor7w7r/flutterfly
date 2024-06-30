// ignore_for_file: avoid_empty_blocks

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/modules/localdb_module.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

class MockLocalDbModule extends Mock implements LocalDbModule {}

class MockBox extends Mock implements Box<bool> {}

void main() {
  group('CupertinoService', () {
    late CupertinoService cupertinoService;
    late MockLocalDbModule mockLocalDbModule;
    late Box<bool> mockBox;

    setUp(() async {
      mockLocalDbModule = MockLocalDbModule();
      mockBox = MockBox();
      when(mockLocalDbModule.isCupertinoDark).thenReturn(false);
      when(mockLocalDbModule.prefsBox).thenAnswer((final _) => mockBox);
      when(() => mockBox.put('cupertinodark', true))
          .thenAnswer((final _) async => Future<void>.value());
      mockLocalDbModule.assignPrefsBox(mockBox);
      cupertinoService = CupertinoService(mockLocalDbModule);
    });

    test('Should initialize with the correct isDark value', () {
      expect(cupertinoService.isDark(), false);
    });

    test('Toggle should invert isDark value', () async {
      expect(cupertinoService.isDark(), false);

      cupertinoService.toggle();
      expect(cupertinoService.isDark(), true);

      reset(mockBox);

      verify(mockLocalDbModule.prefsBox).called(1);
    });

    test('Should notify listeners when toggle is called', () {
      var isNotified = false;
      cupertinoService
        ..addListener(() {
          isNotified = true;
        })
        ..toggle();

      expect(isNotified, true);
    });
  });
}
