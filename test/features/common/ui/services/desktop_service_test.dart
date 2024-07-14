import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/ui/services/desktop_service.dart';

void main() {
  group('DesktopService', () {
    test('initial state should be none', () {
      final desktopService = DesktopService();

      expect(desktopService.state, equals('none'));
    });

    test('state should be mutable and update correctly', () {
      final desktopService = DesktopService();
      const newState = 'updated';
      desktopService.mutate = newState;

      expect(desktopService.state, equals(newState));
    });

    test('listeners should be notified on state change', () {
      final desktopService = DesktopService();
      var isNotified = false;
      desktopService
        ..addListener(() {
          isNotified = true;
        })
        ..mutate = 'newState';

      expect(isNotified, isTrue);
    });
  });
}
