// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../../../features/common/data/dto/bitcoin_dto.dart';

class BitcoinDtoMapper extends ClassMapperBase<BitcoinDto> {
  BitcoinDtoMapper._();

  static BitcoinDtoMapper? _instance;
  static BitcoinDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BitcoinDtoMapper._());
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

  static BitcoinDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BitcoinDto>(map);
  }

  static BitcoinDto fromJson(String json) {
    return ensureInitialized().decodeJson<BitcoinDto>(json);
  }
}

mixin BitcoinDtoMappable {
  String toJson() {
    return BitcoinDtoMapper.ensureInitialized()
        .encodeJson<BitcoinDto>(this as BitcoinDto);
  }

  Map<String, dynamic> toMap() {
    return BitcoinDtoMapper.ensureInitialized()
        .encodeMap<BitcoinDto>(this as BitcoinDto);
  }

  BitcoinDtoCopyWith<BitcoinDto, BitcoinDto, BitcoinDto> get copyWith =>
      _BitcoinDtoCopyWithImpl(this as BitcoinDto, $identity, $identity);
  @override
  String toString() {
    return BitcoinDtoMapper.ensureInitialized()
        .stringifyValue(this as BitcoinDto);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BitcoinDtoMapper.ensureInitialized()
                .isValueEqual(this as BitcoinDto, other));
  }

  @override
  int get hashCode {
    return BitcoinDtoMapper.ensureInitialized().hashValue(this as BitcoinDto);
  }
}

extension BitcoinDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BitcoinDto, $Out> {
  BitcoinDtoCopyWith<$R, BitcoinDto, $Out> get $asBitcoinDto =>
      $base.as((v, t, t2) => _BitcoinDtoCopyWithImpl(v, t, t2));
}

abstract class BitcoinDtoCopyWith<$R, $In extends BitcoinDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? symbol, String? price});
  BitcoinDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BitcoinDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BitcoinDto, $Out>
    implements BitcoinDtoCopyWith<$R, BitcoinDto, $Out> {
  _BitcoinDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BitcoinDto> $mapper =
      BitcoinDtoMapper.ensureInitialized();
  @override
  $R call({String? symbol, String? price}) => $apply(FieldCopyWithData(
      {if (symbol != null) #symbol: symbol, if (price != null) #price: price}));
  @override
  BitcoinDto $make(CopyWithData data) => BitcoinDto(
      data.get(#symbol, or: $value.symbol), data.get(#price, or: $value.price));

  @override
  BitcoinDtoCopyWith<$R2, BitcoinDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BitcoinDtoCopyWithImpl($value, $cast, t);
}
