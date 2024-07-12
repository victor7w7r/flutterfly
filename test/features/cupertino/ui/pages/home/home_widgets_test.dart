import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

class MockCupertinoService extends Mock implements CupertinoService {}

void main() {
  group('HomePage Widgets', () {
    setUp(() async {
      await GetIt.I.reset();

      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      GetIt.I.registerSingleton<Platform>(Platform());
    });

    group('DynamicChip', () {
      patrolWidgetTest(
          'Render widget successfully set '
          'home in true and dark mode in false', (final $) async {
        when(() => GetIt.I<CupertinoService>().isDark).thenReturn(false);

        await $.pumpWidgetAndSettle(
          const CupertinoApp(
            home: CupertinoPageScaffold(child: DynamicChip(isHome: true)),
          ),
        );

        expect($(Container), findsOneWidget);
        expect($(Row), findsOneWidget);
      });

      patrolWidgetTest(
          'Render widget successfully set '
          'home in false and dark mode in true', (final $) async {
        when(() => GetIt.I<CupertinoService>().isDark).thenReturn(true);

        $.tester.view.physicalSize = const Size(1600, 900);

        await $.pumpWidgetAndSettle(
          const CupertinoApp(
            home: CupertinoPageScaffold(child: DynamicChip(isHome: false)),
          ),
        );

        expect($(Container), findsOneWidget);
        expect($(Row), findsOneWidget);
      });
    });
  });
}
