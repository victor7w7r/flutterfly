import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/mvvm.dart';

final class MockObject {
  bool isMarked = false;
}

final class MockNotifier extends ChangeNotifier {
  bool isMarked = false;
}

void main() {
  group('baseMvvm', () {
    setUp(() async => GetIt.I.reset());

    patrolWidgetTest('ViewModel calls onInit and onDispose', (final $) async {
      GetIt.I.registerSingleton(MockObject());

      var isInitCalled = false;
      var isDisposeCalled = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: ViewModel<MockObject>(
            builder: (final _) => const Text('Mock Object'),
            onInit: (final _) => isInitCalled = true,
            onDispose: (final _) => isDisposeCalled = true,
          ),
        ),
      );

      expect(isInitCalled, isTrue);
      expect($('Mock Object'), findsOneWidget);

      await $.pumpWidget(Container());

      expect(isDisposeCalled, isTrue);
    });

    patrolWidgetTest('ViewModel resets lazy singleton when disposeLazy is true',
        (final $) async {
      GetIt.I.registerLazySingleton(MockObject.new);
      await $.pumpWidget(
        MaterialApp(
          home: ViewModel<MockObject>(
            builder: (final _) => const Text('Lazy Singleton'),
            disposeLazy: true,
          ),
        ),
      );

      expect($('Lazy Singleton'), findsOneWidget);

      GetIt.I<MockObject>().isMarked = true;
      expect(GetIt.I<MockObject>().isMarked, true);

      await $.pumpWidget(Container());

      expect(GetIt.I<MockObject>().isMarked, isFalse);
    });

    patrolWidgetTest('ListenViewModel calls onInit and onDispose',
        (final $) async {
      GetIt.I.registerSingleton(MockNotifier());

      var isInitCalled = false;
      var isDisposeCalled = false;

      await $.pumpWidget(
        MaterialApp(
          home: ListenViewModel<MockNotifier>(
            builder: (final _) => const Text('Mock Notifier'),
            onInit: (final _) => isInitCalled = true,
            onDispose: (final _) => isDisposeCalled = true,
          ),
        ),
      );

      expect(isInitCalled, isTrue);
      expect($('Mock Notifier'), findsOneWidget);

      await $.pumpWidget(Container());

      expect(isDisposeCalled, isTrue);
    });

    patrolWidgetTest(
        'ListenViewModel resets lazy singleton when disposeLazy is true',
        (final $) async {
      GetIt.I.registerLazySingleton(MockNotifier.new);
      await $.pumpWidget(
        MaterialApp(
          home: ListenViewModel<MockNotifier>(
            builder: (final _) => const Text('Lazy Singleton'),
            disposeLazy: true,
          ),
        ),
      );

      expect($('Lazy Singleton'), findsOneWidget);

      GetIt.I<MockNotifier>().isMarked = true;
      expect(GetIt.I<MockNotifier>().isMarked, true);

      await $.pumpWidget(Container());

      expect(GetIt.I<MockNotifier>().isMarked, isFalse);
    });

    patrolWidgetTest('LUViewModel calls onInit and onDispose', (final $) async {
      GetIt.I.registerSingleton(MockNotifier());
      GetIt.I.registerSingleton(MockObject());

      var isInitCalled = false;
      var isDisposeCalled = false;

      await $.pumpWidget(
        MaterialApp(
          home: LUViewModel<MockObject, MockNotifier>(
            builder: (final _, final __) => const Text('Mock Notifier'),
            onInit: (final _, final __) {
              isInitCalled = true;
            },
            onDispose: (final _, final __) {
              isDisposeCalled = true;
            },
          ),
        ),
      );

      expect(isInitCalled, isTrue);
      expect($('Mock Notifier'), findsOneWidget);

      await $.pumpWidget(const SizedBox());

      expect(isDisposeCalled, isTrue);
    });

    patrolWidgetTest(
        'LUViewModel resets lazy singleton when disposeLazy is true',
        (final $) async {
      GetIt.I.registerLazySingleton(MockNotifier.new);
      GetIt.I.registerLazySingleton(MockObject.new);

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: LUViewModel<MockObject, MockNotifier>(
            builder: (final _, final __) => const Text('Lazy Singleton'),
            disposeLazyOne: true,
            disposeLazyTwo: true,
          ),
        ),
      );

      expect($('Lazy Singleton'), findsOneWidget);

      GetIt.I<MockNotifier>().isMarked = true;
      GetIt.I<MockObject>().isMarked = true;
      expect(GetIt.I<MockNotifier>().isMarked, true);
      expect(GetIt.I<MockObject>().isMarked, true);

      await $.pumpWidget(const SizedBox());

      expect(GetIt.I<MockNotifier>().isMarked, isFalse);
      expect(GetIt.I<MockObject>().isMarked, isFalse);
    });
  });
}
