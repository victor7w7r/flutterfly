import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/core/error/failure.dart';

void main() {
  group('Failure', () {
    test('ServerFailure should contain correct statusCode and message', () {
      const message = 'Not Found';
      const failure = ServerFailure(message);

      expect(failure.message, message);
    });

    test('ConnectionFailure should contain correct message', () {
      const message = 'No Internet Connection';
      const failure = ConnectionFailure(message);

      expect(failure.message, message);
    });

    test('DatabaseFailure should contain correct message', () {
      const message = 'Database Error';
      const failure = DatabaseFailure(message);

      expect(failure.message, message);
    });
  });
}
