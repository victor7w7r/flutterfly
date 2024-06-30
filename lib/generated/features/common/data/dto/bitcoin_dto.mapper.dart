// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../../../features/common/data/dto/bitcoin_dto.dart';

class BitcoinDtoMapper extends ClassMapperBase<BitcoinDto> {
  BitcoinDtoMapper._();

  static BitcoinDtoMapper? _instance;
  static BitcoinDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BitcoinDtoMapper._());
      BitcoinMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BitcoinDto';

  static String _$symbol(BitcoinDto v) => v.symbol;
  static const Field<BitcoinDto, String> _f$symbol = Field('symbol', _$symbol);
  static String _$price(BitcoinDto v) => v.price;
  static const Field<BitcoinDto, String> _f$price = Field('price', _$price);

  @override
  final MappableFields<BitcoinDto> fields = const {
    #symbol: _f$symbol,
    #price: _f$price,
  };

  static BitcoinDto _instantiate(DecodingData data) {
    return BitcoinDto(data.dec(_f$symbol), data.dec(_f$price));
  }

  @override
  final Function instantiate = _instantiate;

  static BitcoinDto fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BitcoinDto>(map);
  }

  static BitcoinDto fromJsonString(String json) {
    return ensureInitialized().decodeJson<BitcoinDto>(json);
  }
}

mixin BitcoinDtoMappable {
  String toJsonString() {
    return BitcoinDtoMapper.ensureInitialized()
        .encodeJson<BitcoinDto>(this as BitcoinDto);
  }

  Map<String, dynamic> toJson() {
    return BitcoinDtoMapper.ensureInitialized()
        .encodeMap<BitcoinDto>(this as BitcoinDto);
  }
}
