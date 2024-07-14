import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' show Mock, verify;

import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/ui/services/desktop_service.dart';

final class MockDesktopService extends Mock implements DesktopService {}

void main() {
  group('DesktopSelectorController', () {
    late DesktopSelectorController controller;
    late MockDesktopService mockDesktopService;

    setUp(() {
      mockDesktopService = MockDesktopService();
      controller = DesktopSelectorController(mockDesktopService);
    });

    test('initial state is correct', () {
      expect(controller.isInitAnim, isFalse);
    });

    test('init sets isInitAnim to true', () async {
      controller.init();
      await Future<void>.delayed(Duration.zero);
      expect(controller.isInitAnim, isTrue);
    });

    test(
        'exit sets isInitAnim to false and calls '
        'DesktopService.mutate after delay', () async {
      controller.exit('selector');
      expect(controller.isInitAnim, isFalse);

      await Future<void>.delayed(const Duration(seconds: 1));
      verify(() => mockDesktopService.mutate = 'selector').called(1);
    });
  });
}
