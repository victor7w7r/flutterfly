import 'package:dio/dio.dart' show DioException;
import 'package:fpdart/fpdart.dart';

final class HttpNotSuccess implements Exception {

  final int statusCode;
  final String message;

  const HttpNotSuccess(this.statusCode, this.message);

  factory HttpNotSuccess.throwError(
    Object e, StackTrace s
  ) => HttpNotSuccess(
    (e as DioException).response.toOption()
      .map((res) => res.statusCode!)
      .getOrElse(() => 0),
    e.response.toOption()
      .map((res) => res.data['error'] ?? res.data['message'])
      .getOrElse(() => 'Server error, check your internet connection')
  );
}