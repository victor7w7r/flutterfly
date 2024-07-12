import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

final class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('ThemeToggle', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<CupertinoService>(MockCupertinoService.new);
    });

    patrolWidgetTest('ThemeToggle builds correctly', (final $) async {
      final service = GetIt.I<CupertinoService>();
      when(() => service.isDark).thenReturn(false);

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: ThemeToggle()),
        ),
      );

      expect($(CupertinoSwitch), findsOneWidget);
      expect($('Dark Mode'), findsOneWidget);
    });

    patrolWidgetTest('CupertinoSwitch shows correct initial state',
        (final $) async {
      final service = GetIt.I<CupertinoService>();
      when(() => service.isDark).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: ThemeToggle()),
        ),
      );

      final switchWidget = $.tester.widget<CupertinoSwitch>($(CupertinoSwitch));
      expect(switchWidget.value, isTrue);
    });

    patrolWidgetTest('Tapping the switch calls toggle', (final $) async {
      final service = GetIt.I<CupertinoService>();
      when(() => service.isDark).thenReturn(false);

      when(service.toggle).thenAnswer((final _) {});

      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: ThemeToggle()),
        ),
      );
      await $(CupertinoSwitch).tap();
      await $.pump();

      verify(service.toggle).called(1);
    });
  });
}
