import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/theme_toggle.dart';

final class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

void main() {
  group('StorePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<CupertinoService>(MockCupertinoService.new);
      GetIt.I.registerLazySingleton<DataService>(DataService.new);

      when(() => GetIt.I<CupertinoService>().isDark).thenReturn(false);
    });

    patrolWidgetTest('Render widget successfully', (final $) async {
      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: StorePage()),
        ),
      );

      expect($('Store Example'), findsOneWidget);
      expect(
        $('Write anything in this form and send!'),
        findsOneWidget,
      );

      expect($(ThemeToggle), findsOneWidget);
      expect($(Column), findsOneWidget);
      expect($(CupertinoTextField), findsOneWidget);
      expect($(CupertinoButton), findsOneWidget);
    });

    patrolWidgetTest('Perform text change and submit to verify the new state',
        (final $) async {
      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: StorePage()),
        ),
      );

      final txtFieldFinder = $(CupertinoTextField);

      await $.tester.enterText(txtFieldFinder, 'Hello World');
      await $(CupertinoButton).tap();

      final service = GetIt.I<DataService>();
      expect(service.state, 'Hello World');

      await $.tester.pump();
    });

    patrolWidgetTest('Show dialog when text field is empty', (final $) async {
      await $.pumpWidgetAndSettle(
        const CupertinoApp(
          home: CupertinoPageScaffold(child: StorePage()),
        ),
      );

      await $(CupertinoButton).tap();

      await $.pumpAndSettle();

      expect($('Error'), findsOneWidget);
      expect($('Is empty your TextField'), findsOneWidget);

      await $('OK').tap();
      await $.pump();
    });
  });
}
