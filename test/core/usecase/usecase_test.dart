import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/usecase/usecase.dart';

final class MockUseCase extends Mock implements UseCase<int, String> {}

void main() {
  late MockUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUseCase();
  });

  test('should call UseCase with correct params', () async {
    when(() => mockUseCase.call(params: any(named: 'params')))
        .thenAnswer((final _) async => 1);

    await mockUseCase.call(params: 'testeable');

    verify(() => mockUseCase.call(params: 'testeable')).called(1);

    verifyNoMoreInteractions(mockUseCase);

    expect(true, isTrue);
  });
}
