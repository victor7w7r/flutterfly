import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/data/dto/binance_dto.dart';

void main() {
  group('BinanceDto', () {
    late String refRawJson;
    late BinanceDto binanceDto;

    setUp(() {
      binanceDto = const BinanceDto(
        'Detached',
        '',
        '0.00',
        '',
        '',
        '',
        '',
        '100',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
      );
      refRawJson = jsonEncode(binanceDto.toJson());
    });

    test('should create instance to/from JSON', () {
      final dto = BinanceDto.fromJson(jsonDecode(refRawJson));
      final json = jsonEncode(dto.toJson());
      expect(json, refRawJson);
      expect(dto, binanceDto);
    });
  });
}
