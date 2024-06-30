import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';

class MockFailure extends Mock implements Failure {}

void main() {
  late MockFailure mockFailure;

  setUp(() {
    mockFailure = MockFailure();
  });

  group('Failure Test', () {
    test('should check if ServerFailure returns correct message', () {
      const message = 'Server Error';
      when(() => mockFailure.message).thenReturn(message);

      final failure = ServerFailure(mockFailure.message);

      expect(failure.message, message);
    });

    test('should check if ConnectionFailure returns correct message', () {
      const message = 'Connection Error';
      when(() => mockFailure.message).thenReturn(message);

      final failure = ConnectionFailure(mockFailure.message);

      expect(failure.message, message);
    });

    test('should check if DatabaseFailure returns correct message', () {
      const message = 'Database Error';
      when(() => mockFailure.message).thenReturn(message);

      final failure = DatabaseFailure(mockFailure.message);

      expect(failure.message, message);
    });
  });
}
