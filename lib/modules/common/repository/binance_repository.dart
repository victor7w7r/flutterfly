import 'package:fpdart/fpdart.dart' show TaskEither;

import 'package:flutterfly/modules/common/models/binance.dart';
import 'package:flutterfly/modules/common/models/bitcoin.dart';
import 'package:flutterfly/utils/errors.dart';

abstract class BinanceRepository {
  TaskEither<HttpNotSuccess, List<Binance>> getCurrencies();
  TaskEither<HttpNotSuccess, Bitcoin> getBitcoin();
}