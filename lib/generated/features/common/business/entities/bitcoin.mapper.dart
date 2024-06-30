// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../../../features/common/business/entities/bitcoin.dart';

class BitcoinMapper extends ClassMapperBase<Bitcoin> {
  BitcoinMapper._();

  static BitcoinMapper? _instance;
  static BitcoinMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BitcoinMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Bitcoin';

  static String _$symbol(Bitcoin v) => v.symbol;
  static const Field<Bitcoin, String> _f$symbol = Field('symbol', _$symbol);
  static String _$price(Bitcoin v) => v.price;
  static const Field<Bitcoin, String> _f$price = Field('price', _$price);

  @override
  final MappableFields<Bitcoin> fields = const {
    #symbol: _f$symbol,
    #price: _f$price,
  };

  static Bitcoin _instantiate(DecodingData data) {
    return Bitcoin(data.dec(_f$symbol), data.dec(_f$price));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin BitcoinMappable {
  BitcoinCopyWith<Bitcoin, Bitcoin, Bitcoin> get copyWith =>
      _BitcoinCopyWithImpl(this as Bitcoin, $identity, $identity);
  @override
  String toString() {
    return BitcoinMapper.ensureInitialized().stringifyValue(this as Bitcoin);
  }

  @override
  bool operator ==(Object other) {
    return BitcoinMapper.ensureInitialized()
        .equalsValue(this as Bitcoin, other);
  }

  @override
  int get hashCode {
    return BitcoinMapper.ensureInitialized().hashValue(this as Bitcoin);
  }
}

extension BitcoinValueCopy<$R, $Out> on ObjectCopyWith<$R, Bitcoin, $Out> {
  BitcoinCopyWith<$R, Bitcoin, $Out> get $asBitcoin =>
      $base.as((v, t, t2) => _BitcoinCopyWithImpl(v, t, t2));
}

abstract class BitcoinCopyWith<$R, $In extends Bitcoin, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? symbol, String? price});
  BitcoinCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BitcoinCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Bitcoin, $Out>
    implements BitcoinCopyWith<$R, Bitcoin, $Out> {
  _BitcoinCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Bitcoin> $mapper =
      BitcoinMapper.ensureInitialized();
  @override
  $R call({String? symbol, String? price}) => $apply(FieldCopyWithData(
      {if (symbol != null) #symbol: symbol, if (price != null) #price: price}));
  @override
  Bitcoin $make(CopyWithData data) => Bitcoin(
      data.get(#symbol, or: $value.symbol), data.get(#price, or: $value.price));

  @override
  BitcoinCopyWith<$R2, Bitcoin, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BitcoinCopyWithImpl($value, $cast, t);
}
