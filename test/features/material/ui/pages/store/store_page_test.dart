import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/material/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

class MockPlatform extends Mock implements Platform {}

void main() {
  group('StorePage', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<MaterialService>(MockMaterialService.new);
      GetIt.I.registerLazySingleton<DataService>(DataService.new);
      GetIt.I.registerLazySingleton<Platform>(MockPlatform.new);
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);
    });

    testWidgets('Render widget successfully', (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(home: StorePage(secondMockChild: SizedBox())),
      );

      expect(find.text('Store Example'), findsOneWidget);
      expect(
        find.text('Write anything in this form and send!'),
        findsOneWidget,
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Perform text change and submit to verify the new state',
        (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(home: StorePage(secondMockChild: SizedBox())),
      );

      final txtFieldFinder = find.byType(TextField);

      await tester.enterText(txtFieldFinder, 'Hello World');
      await tester.tap(find.byType(ElevatedButton));

      final service = GetIt.I.get<DataService>();
      expect(service.state(), 'Hello World');

      await tester.pump();
    });

    testWidgets('Show dialog when text field is empty', (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(home: StorePage(secondMockChild: SizedBox())),
      );

      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Is empty your TextField'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pump();
    });
  });
}
