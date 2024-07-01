import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('HomePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<CupertinoService>(MockCupertinoService.new);
      GetIt.I.registerLazySingleton<DataService>(DataService.new);

      final service = GetIt.I.get<CupertinoService>();
      when(service.isDark).thenReturn(false);
    });

    testWidgets('Render widget successfully', (final tester) async {
      GetIt.I.get<DataService>().mutate = 'Hello, Flutter!';

      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: HomePage()),
        ),
      );

      expect(find.text('Happy Hacking!, Dart... Dart...'), findsOneWidget);
      expect(find.text('Made with love by '), findsOneWidget);

      expect(find.byType(ThemeToggle), findsOneWidget);
      expect(find.byType(DynamicChip), findsWidgets);
    });

    testWidgets('Render widget successfully with empty state',
        (final tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: HomePage()),
        ),
      );

      expect(find.text('Happy Hacking!, Dart... Dart...'), findsOneWidget);
      expect(find.text('Made with love by '), findsOneWidget);
      expect(find.text('Store state: Not yet.'), findsOneWidget);
      expect(find.byType(ThemeToggle), findsOneWidget);
      expect(find.byType(DynamicChip), findsWidgets);
    });
  });
}
