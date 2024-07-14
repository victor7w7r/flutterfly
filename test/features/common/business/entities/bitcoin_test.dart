import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/business/entities/bitcoin.dart';

void main() {
  group('Bitcoin', () {
    test('two instances with the same properties should be equal', () {
      final bitcoin = Bitcoin.dummy();
      final bitcoin2 = Bitcoin.dummy();

      expect(bitcoin, equals(bitcoin2));
    });

    test('two instances with different properties should be different', () {
      final bitcoin = Bitcoin.dummy();
      final bitcoin2 = Bitcoin.detached();

      expect(bitcoin, isNot(equals(bitcoin2)));
    });
  });
}
