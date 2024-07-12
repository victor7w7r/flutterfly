import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/query.dart';
import '../../setup.dart';

void main() {
  group('BaseQueryBuilder', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = MockPathProviderPlatform();
      await QueryClient.initialize(cachePrefix: 'datable');
    });

    patrolWidgetTest(
      'Displays loading widget',
      (final $) async => $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => Future.delayed(const Duration(seconds: 3)),
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
                def: 'Default',
              ),
            ),
          ),
        );

        expect($('Loading...'), findsOneWidget);
      }),
    );

    patrolWidgetTest(
      'Displays success widget with data',
      (final $) async => $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(
          QueryClientProvider(
            child: MaterialApp(
              home: Scaffold(
                body: BaseQueryBuilder<String, String>(
                  'testKey',
                  () async => 'TestData',
                  loading: () => const Text('Loading...'),
                  error: (final _, final __) => const Text('Error'),
                  success: (final _, final data) => Text(data),
                  def: 'Default',
                ),
              ),
            ),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 500));
        await $.pump();

        expect($('TestData'), findsOneWidget);
      }),
    );

    patrolWidgetTest(
      'Displays loading widget when data equals default value',
      (final $) async => $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => 'Default',
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
                def: 'Default',
              ),
            ),
          ),
        );

        await $.pump();

        expect($('Loading...'), findsOneWidget);
      }),
    );

    patrolWidgetTest(
      'Query access function is called',
      (final $) async => $.tester.runAsync(() async {
        var wasCalled = false;
        await $.pumpWidgetAndSettle(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => 'TestData',
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
                queryAccess: (final _) => wasCalled = true,
              ),
            ),
          ),
        );

        await $.pump();

        expect(wasCalled, true);
      }),
    );
    patrolWidgetTest(
      'Set the mockQuery in true',
      (final $) async => $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(
          QueryClientProvider(
            child: MaterialApp(
              home: BaseQueryBuilder<String, String>(
                'testKey',
                () async => 'TestData',
                loading: () => const Text('Loading...'),
                error: (final _, final __) => const Text('Error'),
                success: (final _, final __) => const Text('Success'),
                mockError: true,
              ),
            ),
          ),
        );

        await Future<void>.delayed(const Duration(milliseconds: 500));
        await $.pump();

        expect($('Error'), findsOneWidget);
      }),
    );
  });
}
