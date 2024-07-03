import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/blur_button.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';

class MockFluentService extends Mock
    with ChangeNotifier
    implements FluentService {}

class MockPlatform extends Mock implements Platform {}

void main() {
  group('StorePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<FluentService>(MockFluentService.new);
      GetIt.I.registerLazySingleton<DataService>(DataService.new);
      GetIt.I.registerLazySingleton<Platform>(MockPlatform.new);
      final service = GetIt.I.get<FluentService>();
      when(service.state).thenReturn(FluentThemeApp.dark());
    });

    testWidgets('Render widget successfully', (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isWeb).thenReturn(false);

      await tester.pumpWidget(
        const FluentApp(home: StorePage(secondMockChild: SizedBox())),
      );

      expect(
        find.text('Write anything in this form and send!'),
        findsOneWidget,
      );

      expect(find.byType(Column), findsNWidgets(3));
      expect(find.byType(BlurButton), findsNWidgets(2));
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('Perform text change and submit to verify the new state',
        (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();
        when(platform.isWeb).thenReturn(true);

        await tester.pumpWidget(
          const FluentApp(home: StorePage(secondMockChild: SizedBox())),
        );

        final txtFieldFinder = find.byType(TextBox);

        await tester.enterText(txtFieldFinder, 'test');
        await tester.tap(find.text('Send'));

        final service = GetIt.I.get<DataService>();
        expect(service.state(), 'test');
      });
    });

    testWidgets('Show dialog when text field is empty', (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();
        when(platform.isWeb).thenReturn(true);

        await tester.pumpWidget(
          const FluentApp(home: StorePage(secondMockChild: SizedBox())),
        );

        await tester.tap(find.text('Send'));

        await tester.pumpAndSettle();

        expect(find.text('Error'), findsOneWidget);
        expect(find.text('Is empty your Text'), findsOneWidget);

        await tester.tap(find.text('OK'));
        await tester.pump();
      });
    });
  });
}
