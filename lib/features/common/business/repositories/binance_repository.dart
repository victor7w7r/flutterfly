import 'package:fast_immutable_collections/fast_immutable_collections.dart'
    show IList;

import 'package:fpdart/fpdart.dart' show TaskEither;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';

// ignore: one_member_abstracts
abstract class BinanceRepository {
  TaskEither<Failure, IList<Binance>> getCurrencies();
}
