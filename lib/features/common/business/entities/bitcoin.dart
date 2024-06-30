import 'package:dart_mappable/dart_mappable.dart';

part '../../../../generated/features/common/business/entities/bitcoin.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
base class Bitcoin with BitcoinMappable {
  const Bitcoin(
    this.symbol,
    this.price,
  );

  factory Bitcoin.dummy() => const Bitcoin('DUMMY', '0.00');

  factory Bitcoin.detached() => const Bitcoin('DETACHED', '0.00');

  final String symbol;
  final String price;
}
