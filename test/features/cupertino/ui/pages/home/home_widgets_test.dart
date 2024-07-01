import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

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
      testWidgets(
          'Render widget successfully set '
          'home in true and dark mode in false', (final tester) async {
        final service = GetIt.I.get<CupertinoService>();
        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(
          const CupertinoApp(
            home: CupertinoPageScaffold(child: DynamicChip(isHome: true)),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });

      testWidgets(
          'Render widget successfully set '
          'home in false and dark mode in true', (final tester) async {
        final service = GetIt.I.get<CupertinoService>();
        when(service.isDark).thenReturn(true);

        tester.view.physicalSize = const Size(1600, 900);

        await tester.pumpWidget(
          const CupertinoApp(
            home: CupertinoPageScaffold(child: DynamicChip(isHome: false)),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });
    });
  });
}
