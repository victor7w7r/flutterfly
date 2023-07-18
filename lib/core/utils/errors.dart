import 'package:dio/dio.dart' show DioException;
import 'package:fpdart/fpdart.dart';

final class HttpNotSuccess implements Exception {

  const HttpNotSuccess(this.statusCode, this.message);

  factory HttpNotSuccess.throwError(
    // ignore: avoid_unused_constructor_parameters
    final Object e, final StackTrace s
  ) => HttpNotSuccess(
    (e as DioException).response.toOption()
      .map((final res) => res.statusCode!)
      .getOrElse(() => 0),
    e.response.toOption()
      // ignore: avoid_dynamic_calls
      .map((final res) => res.data['error'] ?? res.data['message'])
      .getOrElse(() => 'Server error, check your internet connection')
  );

  final int statusCode;
  final String message;
}