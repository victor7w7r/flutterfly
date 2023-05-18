import 'package:freezed_annotation/freezed_annotation.dart';

part 'bitcoin.freezed.dart';
part 'bitcoin.g.dart';

@freezed
class Bitcoin with _$Bitcoin{

  const factory Bitcoin(
    String symbol,
    String price
  ) = _Bitcoin;

  factory Bitcoin.fromJson(
    Map<String, dynamic> json
  ) => _$BitcoinFromJson(json);

  factory Bitcoin.dummy() =>
    const Bitcoin('DUMMY', '0.00');

}