import 'package:dart_mappable/dart_mappable.dart';

import 'package:flutterfly/features/common/business/entities/binance.dart';

part '../../../../generated/features/common/data/dto/binance_dto.mapper.dart';

@MappableClass(
  generateMethods: GenerateMethods.decode | GenerateMethods.encode,
)
final class BinanceDto extends Binance with BinanceDtoMappable {
  const BinanceDto(
    super.symbol,
    super.priceChange,
    super.priceChangePercent,
    super.weightedAvgPrice,
    super.prevClosePrice,
    super.lastPrice,
    super.lastQty,
    super.bidPrice,
    super.bidQty,
    super.askPrice,
    super.askQty,
    super.openPrice,
    super.highPrice,
    super.lowPrice,
    super.volume,
    super.quoteVolume,
    super.openTime,
    super.closeTime,
    super.firstId,
    super.lastId,
    super.count,
  );

  static const fromJson = BinanceDtoMapper.fromJson;
}
