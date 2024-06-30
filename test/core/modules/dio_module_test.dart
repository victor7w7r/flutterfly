import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/core/constants/constants.dart';
import 'package:flutterfly/core/modules/dio_module.dart';

class DioModuleImpl extends DioModule {}

void main() {
  late DioModule dioModule;
  setUp(() {
    dioModule = DioModuleImpl();
  });

  group('DioModule', () {
    test('route should return empty string', () {
      expect(dioModule.route, '');
    });

    test('dio should return Dio instance with correct baseUrl and headers', () {
      final dio = dioModule.dio;
      expect(dio.options.baseUrl, '$protocol://$host');
      expect(dio.options.headers, {'Content-Type': 'application/json'});
    });
  });
}
