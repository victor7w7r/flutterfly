import 'package:dart_mappable/dart_mappable.dart';

import 'package:flutterfly/features/common/business/entities/bitcoin.dart';

part '../../../../generated/features/common/data/dto/bitcoin_dto.mapper.dart';

@MappableClass(
  generateMethods: GenerateMethods.decode | GenerateMethods.encode,
)
final class BitcoinDto extends Bitcoin with BitcoinDtoMappable {
  const BitcoinDto(super.symbol, super.price);

  static const fromJson = BitcoinDtoMapper.fromJson;
}
