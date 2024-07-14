import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/blur_button.dart';
import '../../../../../setup.dart';

final class MockFluentService extends Mock
    with ChangeNotifier
    implements FluentService {}

final class MockPlatform extends Mock implements Platform {}

void main() {
  group('StorePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());
      GetIt.I.registerSingleton(DataService());
      GetIt.I.registerSingleton<Platform>(MockPlatform());

      when(() => GetIt.I<FluentService>().state)
          .thenReturn(FluentThemeApp.dark());
    });

    patrolWidgetTest('render widget successfully', (final $) async {
      disableOverflowErrors();
      when(() => GetIt.I<Platform>().isWeb).thenReturn(false);

      GetIt.I<DataService>().mutate = '.';

      await $.pumpWidgetAndSettle(
        const FluentApp(home: StorePage(secondMockChild: SizedBox())),
      );

      expect(
        $('Write anything in this form and send!'),
        findsOneWidget,
      );

      expect($(Column), findsNWidgets(3));
      expect($(BlurButton), findsNWidgets(2));
      expect($(SizedBox), findsWidgets);
    });

    patrolWidgetTest('perform text change and submit to verify the new state',
        (final $) async {
      when(() => GetIt.I<Platform>().isWeb).thenReturn(true);

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(
          const FluentApp(home: StorePage(secondMockChild: SizedBox())),
        );

        final txtFieldFinder = $(TextBox);

        await $.enterText(txtFieldFinder, 'test');
        await $('Send').tap();

        expect(GetIt.I<DataService>().state, 'test');
      });
    });

    patrolWidgetTest('Show dialog when text field is empty', (final $) async {
      when(() => GetIt.I<Platform>().isWeb).thenReturn(true);

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(
          const FluentApp(home: StorePage(secondMockChild: SizedBox())),
        );

        await $('Send').tap();
        await $.pumpAndSettle();

        expect($('Error'), findsOneWidget);
        expect($('Is empty your Text'), findsOneWidget);

        await $('OK').tap();
      });
    });

    patrolWidgetTest('Press to Go To Home Button', (final $) async {
      when(() => GetIt.I<Platform>().isWeb).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const FluentApp(
          home: StorePage(secondMockChild: SizedBox()),
        ),
      );

      await $('Go to Home').tap();
      await $.pumpAndSettle();

      expect($(StorePage), findsOneWidget);
    });
  });
}
