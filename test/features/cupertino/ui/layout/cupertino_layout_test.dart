import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/cupertino/ui/layout/cupertino_layout.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

final class MockPlatform extends Mock implements Platform {}

final class MockCupertinoService extends Mock implements CupertinoService {}

void main() {
  group('Title', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      GetIt.I.registerSingleton<Platform>(Platform());
    });

    patrolWidgetTest('render widget successfully', (final $) async {
      final service = GetIt.I<CupertinoService>();

      when(() => service.isDark).thenReturn(false);
      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const CupertinoLayout(child: SizedBox()));

        expect($(CupertinoApp), findsOneWidget);
        expect($(CupertinoPageScaffold), findsOneWidget);
        expect($(CupertinoTabScaffold), findsOneWidget);
        expect($(SizedBox), findsAtLeastNWidgets(3));

        reset(service);

        when(() => service.isDark).thenReturn(false);

        await $.pumpWidget(const CupertinoLayout(child: SizedBox()));

        verify(() => service.isDark).called(2);
      });
    });
  });
}
