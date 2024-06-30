import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('ThemeToggle', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<CupertinoService>(MockCupertinoService.new);
    });

    testWidgets('ThemeToggle builds correctly', (final tester) async {
      final service = GetIt.I.get<CupertinoService>();
      when(service.isDark).thenReturn(false);

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: ThemeToggle()),
        ),
      );

      expect(find.byType(CupertinoSwitch), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('CupertinoSwitch shows correct initial state',
        (final tester) async {
      final service = GetIt.I.get<CupertinoService>();
      when(service.isDark).thenReturn(true);

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: ThemeToggle()),
        ),
      );

      final switchWidget =
          tester.widget<CupertinoSwitch>(find.byType(CupertinoSwitch));
      expect(switchWidget.value, isTrue);
    });

    testWidgets('Tapping the switch calls toggle', (final tester) async {
      final service = GetIt.I.get<CupertinoService>();
      when(service.isDark).thenReturn(false);

      // ignore: avoid_empty_blocks
      when(service.toggle).thenAnswer((final _) {});

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: ThemeToggle()),
        ),
      );
      await tester.tap(find.byType(CupertinoSwitch));
      await tester.pump();

      verify(service.toggle).called(1);
    });
  });
}
