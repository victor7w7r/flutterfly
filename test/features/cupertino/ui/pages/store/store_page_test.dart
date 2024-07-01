import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('StorePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<CupertinoService>(MockCupertinoService.new);
      GetIt.I.registerLazySingleton<DataService>(DataService.new);

      final service = GetIt.I.get<CupertinoService>();
      when(service.isDark).thenReturn(false);
    });

    testWidgets('Render widget successfully', (final tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: StorePage()),
        ),
      );

      expect(find.text('Store Example'), findsOneWidget);
      expect(
        find.text('Write anything in this form and send!'),
        findsOneWidget,
      );

      expect(find.byType(ThemeToggle), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(CupertinoTextField), findsOneWidget);
      expect(find.byType(CupertinoButton), findsOneWidget);
    });

    testWidgets('Perform text change and submit to verify the new state',
        (final tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: StorePage()),
        ),
      );

      final txtFieldFinder = find.byType(CupertinoTextField);

      await tester.enterText(txtFieldFinder, 'Hello World');
      await tester.tap(find.byType(CupertinoButton));

      final service = GetIt.I.get<DataService>();
      expect(service.state(), 'Hello World');

      await tester.pump();
    });

    testWidgets('Show dialog when text field is empty', (final tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: StorePage()),
        ),
      );

      await tester.tap(find.byType(CupertinoButton));

      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Is empty your TextField'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pump();
    });
  });
}
