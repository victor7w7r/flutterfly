import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/fluent/ui/layout/fluent_layout.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

class MockPlatform extends Mock implements Platform {}

class MockFluentService extends Mock implements FluentService {}

void main() {
  group('FluentLayout', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());

      final srv = GetIt.I<FluentService>();
      when(srv.state).thenReturn(FluentThemeApp.dark());
    });

    testWidgets('Render widget successfully', (final tester) async {
      await tester.runAsync(() async {
        final service = GetIt.I<FluentService>();

        await tester.pumpWidget(const FluentLayout(child: SizedBox()));

        final widget = tester.widget<FluentApp>(find.byType(FluentApp));

        expect(find.byType(FluentApp), findsOneWidget);
        expect(widget.color, service.state().themeColor.first);
      });
    });

    testWidgets('Navigate to Store Page', (final tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const FluentLayout(child: SizedBox()));

        expect(find.byType(HomePage), findsOneWidget);
        expect(find.byType(StorePage), findsNothing);

        final BuildContext context = tester.element(find.byType(HomePage));
        unawaited(Navigator.pushNamed(context, '/store'));

        await tester.pumpAndSettle();

        expect(find.byType(StorePage), findsOneWidget);
      });
    });
  });
}
