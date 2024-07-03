import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:watch_it/watch_it.dart' show GetIt;

import 'package:flutterfly/core/utils/mvvm.dart';

class MockObject {
  bool isMarked = false;
}

class MockNotifier extends ChangeNotifier {
  bool isMarked = false;
}

void main() {
  group('baseMvvm', () {
    setUp(() async => GetIt.I.reset());

    testWidgets('ViewModel calls onInit and onDispose', (final tester) async {
      GetIt.I.registerSingleton<MockObject>(MockObject());
      var isInitCalled = false;
      var isDisposeCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ViewModel<MockObject>(
            onInit: (final _) {
              isInitCalled = true;
            },
            onDispose: (final _) {
              isDisposeCalled = true;
            },
            builder: (final _) => const Text('Mock Object'),
          ),
        ),
      );

      expect(isInitCalled, isTrue);
      expect(find.text('Mock Object'), findsOneWidget);

      await tester.pumpWidget(Container());

      expect(isDisposeCalled, isTrue);
    });

    testWidgets('ViewModel resets lazy singleton when disposeLazy is true',
        (final tester) async {
      GetIt.I.registerLazySingleton<MockObject>(MockObject.new);
      await tester.pumpWidget(
        MaterialApp(
          home: ViewModel<MockObject>(
            disposeLazy: true,
            builder: (final _) => const Text('Lazy Singleton'),
          ),
        ),
      );

      expect(find.text('Lazy Singleton'), findsOneWidget);

      GetIt.I.get<MockObject>().isMarked = true;
      expect(GetIt.I.get<MockObject>().isMarked, true);

      await tester.pumpWidget(Container());

      expect(GetIt.I.get<MockObject>().isMarked, isFalse);
    });

    testWidgets('ListenViewModel calls onInit and onDispose',
        (final tester) async {
      GetIt.I.registerSingleton<MockNotifier>(MockNotifier());
      var isInitCalled = false;
      var isDisposeCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ListenViewModel<MockNotifier>(
            onInit: (final _) {
              isInitCalled = true;
            },
            onDispose: (final _) {
              isDisposeCalled = true;
            },
            builder: (final _) => const Text('Mock Notifier'),
          ),
        ),
      );

      expect(isInitCalled, isTrue);
      expect(find.text('Mock Notifier'), findsOneWidget);

      await tester.pumpWidget(Container());

      expect(isDisposeCalled, isTrue);
    });

    testWidgets(
        'ListenViewModel resets lazy singleton when disposeLazy is true',
        (final tester) async {
      GetIt.I.registerLazySingleton<MockNotifier>(MockNotifier.new);
      await tester.pumpWidget(
        MaterialApp(
          home: ListenViewModel<MockNotifier>(
            disposeLazy: true,
            builder: (final _) => const Text('Lazy Singleton'),
          ),
        ),
      );

      expect(find.text('Lazy Singleton'), findsOneWidget);

      GetIt.I.get<MockNotifier>().isMarked = true;
      expect(GetIt.I.get<MockNotifier>().isMarked, true);

      await tester.pumpWidget(Container());

      expect(GetIt.I.get<MockNotifier>().isMarked, isFalse);
    });

    testWidgets('LUViewModel calls onInit and onDispose', (final tester) async {
      GetIt.I.registerSingleton<MockNotifier>(MockNotifier());
      GetIt.I.registerSingleton<MockObject>(MockObject());
      var isInitCalled = false;
      var isDisposeCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: LUViewModel<MockObject, MockNotifier>(
            onInit: (final _, final __) {
              isInitCalled = true;
            },
            onDispose: (final _, final __) {
              isDisposeCalled = true;
            },
            builder: (final _, final __) => const Text('Mock Notifier'),
          ),
        ),
      );

      expect(isInitCalled, isTrue);
      expect(find.text('Mock Notifier'), findsOneWidget);

      await tester.pumpWidget(Container());

      expect(isDisposeCalled, isTrue);
    });

    testWidgets('LUViewModel resets lazy singleton when disposeLazy is true',
        (final tester) async {
      GetIt.I.registerLazySingleton<MockNotifier>(MockNotifier.new);
      GetIt.I.registerLazySingleton<MockObject>(MockObject.new);
      await tester.pumpWidget(
        MaterialApp(
          home: LUViewModel<MockObject, MockNotifier>(
            disposeLazyOne: true,
            disposeLazyTwo: true,
            builder: (final _, final __) => const Text('Lazy Singleton'),
          ),
        ),
      );

      expect(find.text('Lazy Singleton'), findsOneWidget);

      GetIt.I.get<MockNotifier>().isMarked = true;
      GetIt.I.get<MockObject>().isMarked = true;
      expect(GetIt.I.get<MockNotifier>().isMarked, true);
      expect(GetIt.I.get<MockObject>().isMarked, true);

      await tester.pumpWidget(Container());

      expect(GetIt.I.get<MockNotifier>().isMarked, isFalse);
      expect(GetIt.I.get<MockObject>().isMarked, isFalse);
    });
  });
}
