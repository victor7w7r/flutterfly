import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/material/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

final class MockPlatform extends Mock implements Platform {}

void main() {
  group('StorePage', () {
    setUp(() async {
      await GetIt.I.reset();

      GetIt.I.registerLazySingleton<MaterialService>(MockMaterialService.new);
      GetIt.I.registerLazySingleton(DataService.new);
      GetIt.I.registerLazySingleton<Platform>(MockPlatform.new);

      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
    });

    patrolWidgetTest('render widget successfully', (final $) async {
      when(() => GetIt.I<Platform>().isMacOS).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(home: StorePage(secondMockChild: SizedBox())),
      );

      expect($('Store Example'), findsOneWidget);
      expect(
        $('Write anything in this form and send!'),
        findsOneWidget,
      );

      expect($(Column), findsOneWidget);
      expect($(TextField), findsOneWidget);
      expect($(ElevatedButton), findsOneWidget);
    });

    patrolWidgetTest('perform text change and submit to verify the new state',
        (final $) async {
      when(() => GetIt.I<Platform>().isMacOS).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(home: StorePage(secondMockChild: SizedBox())),
      );

      await $.enterText($(TextField), 'Hello World');
      await $(ElevatedButton).tap();

      expect(GetIt.I<DataService>().state, 'Hello World');
    });

    patrolWidgetTest('show dialog when text field is empty', (final $) async {
      when(() => GetIt.I<Platform>().isMacOS).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(home: StorePage(secondMockChild: SizedBox())),
      );

      await $(ElevatedButton).tap();

      await $.pumpAndSettle();

      expect($('Error'), findsOneWidget);
      expect($('Is empty your TextField'), findsOneWidget);

      await $('OK').tap();
    });
  });
}
