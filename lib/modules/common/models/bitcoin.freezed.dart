// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bitcoin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bitcoin _$BitcoinFromJson(Map<String, dynamic> json) {
  return _Bitcoin.fromJson(json);
}

/// @nodoc
mixin _$Bitcoin {
  String get symbol => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BitcoinCopyWith<Bitcoin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BitcoinCopyWith<$Res> {
  factory $BitcoinCopyWith(Bitcoin value, $Res Function(Bitcoin) then) =
      _$BitcoinCopyWithImpl<$Res, Bitcoin>;
  @useResult
  $Res call({String symbol, String price});
}

/// @nodoc
class _$BitcoinCopyWithImpl<$Res, $Val extends Bitcoin>
    implements $BitcoinCopyWith<$Res> {
  _$BitcoinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BitcoinCopyWith<$Res> implements $BitcoinCopyWith<$Res> {
  factory _$$_BitcoinCopyWith(
          _$_Bitcoin value, $Res Function(_$_Bitcoin) then) =
      __$$_BitcoinCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String symbol, String price});
}

/// @nodoc
class __$$_BitcoinCopyWithImpl<$Res>
    extends _$BitcoinCopyWithImpl<$Res, _$_Bitcoin>
    implements _$$_BitcoinCopyWith<$Res> {
  __$$_BitcoinCopyWithImpl(_$_Bitcoin _value, $Res Function(_$_Bitcoin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? price = null,
  }) {
    return _then(_$_Bitcoin(
      null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bitcoin implements _Bitcoin {
  const _$_Bitcoin(this.symbol, this.price);

  factory _$_Bitcoin.fromJson(Map<String, dynamic> json) =>
      _$$_BitcoinFromJson(json);

  @override
  final String symbol;
  @override
  final String price;

  @override
  String toString() {
    return 'Bitcoin(symbol: $symbol, price: $price)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bitcoin &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, symbol, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BitcoinCopyWith<_$_Bitcoin> get copyWith =>
      __$$_BitcoinCopyWithImpl<_$_Bitcoin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BitcoinToJson(
      this,
    );
  }
}

abstract class _Bitcoin implements Bitcoin {
  const factory _Bitcoin(final String symbol, final String price) = _$_Bitcoin;

  factory _Bitcoin.fromJson(Map<String, dynamic> json) = _$_Bitcoin.fromJson;

  @override
  String get symbol;
  @override
  String get price;
  @override
  @JsonKey(ignore: true)
  _$$_BitcoinCopyWith<_$_Bitcoin> get copyWith =>
      throw _privateConstructorUsedError;
}
