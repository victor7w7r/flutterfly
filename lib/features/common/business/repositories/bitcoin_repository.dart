import 'package:fpdart/fpdart.dart' show TaskEither;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/bitcoin.dart';

// ignore: one_member_abstracts
abstract class BitcoinRepository {
  TaskEither<Failure, Bitcoin> getBitcoin();
}
