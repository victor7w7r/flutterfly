import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/core/modules/localdb_module.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDbModule extends Mock implements LocalDbModule {}

void main() {
  group('CupertinoService', () {
    late CupertinoService cupertinoService;
    late MockLocalDbModule mockLocalDbModule;

    setUp(() {
      mockLocalDbModule = MockLocalDbModule();
      when(mockLocalDbModule.isCupertinoDark).thenReturn(false);
      cupertinoService = CupertinoService(mockLocalDbModule);
    });

    test('Should initialize with the correct isDark value', () {
      expect(cupertinoService.isDark, false);
    });

    test('Toggle should invert isDark value', () {
      expect(cupertinoService.isDark, false);

      cupertinoService.toggle();
      expect(cupertinoService.isDark, true);

      cupertinoService.toggle();
      expect(cupertinoService.isDark, false);
    });

    test('Toggle should call LocalDbModule to persist the new isDark value',
        () {
      cupertinoService.toggle();

      verify(() async => mockLocalDbModule.prefsBox()).called(1);

      cupertinoService.toggle();

      verify(() async => mockLocalDbModule.prefsBox()).called(1);
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
