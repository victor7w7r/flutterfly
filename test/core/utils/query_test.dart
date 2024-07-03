import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutterfly/core/utils/query.dart';
import '../../setup.dart';

void main() {
  group('BaseQueryBuilder', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = MockPathProviderPlatform();
      await QueryClient.initialize(cachePrefix: 'datable');
    });

    testWidgets('Displays loading widget', (final tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => Future.delayed(const Duration(seconds: 3)),
                def: 'Default',
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
              ),
            ),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
      });
    });

    testWidgets('Displays success widget with data', (final tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          QueryClientProvider(
            child: MaterialApp(
              home: Scaffold(
                body: BaseQueryBuilder<String, String>(
                  'testKey',
                  def: 'Default',
                  () async => 'TestData',
                  loading: () => const Text('Loading...'),
                  error: (final _, final __) => const Text('Error'),
                  success: (final _, final data) => Text(data),
                ),
              ),
            ),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 500));
        await tester.pump();

        expect(find.text('TestData'), findsOneWidget);
      });
    });

    testWidgets('Displays loading widget when data equals default value',
        (final tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => 'Default',
                def: 'Default',
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text('Loading...'), findsOneWidget);
      });
    });

    testWidgets('Query access function is called', (final tester) async {
      await tester.runAsync(() async {
        var wasCalled = false;
        await tester.pumpWidget(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => 'TestData',
                queryAccess: (final _) => wasCalled = true,
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
              ),
            ),
          ),
        );

        await tester.pump();

        expect(wasCalled, true);
      });
    });
    testWidgets('Set the mockQuery in true', (final tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => 'TestData',
                mockError: true,
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
              ),
            ),
          ),
        );

        await Future<void>.delayed(const Duration(milliseconds: 500));
        await tester.pump();

        expect(find.text('Error'), findsOneWidget);
      });
    });
  });
}
