import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/ui/services/data_service.dart';

void main() {
  group('DataService', () {
    late DataService dataService;

    setUp(() {
      dataService = DataService();
    });

    test('Should start with an empty state', () {
      expect(dataService.state(), isEmpty);
    });

    test('Mutate should update state and notify listeners', () {
      var listenerCallCount = 0;
      dataService
        ..addListener(() {
          listenerCallCount++;
        })
        ..mutate = 'new state';

      expect(dataService.state(), equals('new state'));
      expect(listenerCallCount, 1);
    });

    test('State getter should return the current state', () {
      dataService.mutate = 'another state';

      expect(dataService.state(), equals('another state'));
    });
  });
}
