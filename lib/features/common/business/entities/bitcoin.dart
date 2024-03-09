import 'package:equatable/equatable.dart';

base class Bitcoin extends Equatable {
  const Bitcoin(
    this.symbol,
    this.price,
  );

  factory Bitcoin.dummy() => const Bitcoin('DUMMY', '0.00');

  final String symbol;
  final String price;

  @override
  List<Object> get props => [symbol, price];
}
