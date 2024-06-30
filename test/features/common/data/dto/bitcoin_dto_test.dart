import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/data/dto/bitcoin_dto.dart';

void main() {
  group('BitcoinDto', () {
    late String refRawJson;
    late BitcoinDto bitcoinDto;

    setUp(() {
      bitcoinDto = const BitcoinDto('BTC', '1000');
      refRawJson = jsonEncode(bitcoinDto.toJson());
    });

    test('should create instance to/from JSON', () {
      final dto = BitcoinDto.fromJson(jsonDecode(refRawJson));
      final json = jsonEncode(dto.toJson());
      expect(json, refRawJson);
      expect(dto, bitcoinDto);
    });
  });
}
