import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/business/entities/binance.dart';

void main() {
  group('Binance', () {
    test('Two instances with the same properties should be equal', () {
      final binance = Binance.detached();
      final binance2 = Binance.detached();

      expect(binance, equals(binance2));
    });

    test('Two instances with different properties should be different', () {
      final binance = Binance.detached();
      final binance2 = Binance.dummyGen().first;

      expect(binance, isNot(equals(binance2)));
    });
  });
}
