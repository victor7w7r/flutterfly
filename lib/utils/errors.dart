import 'package:dio/dio.dart' show DioError;
import 'package:fpdart/fpdart.dart' show Option, OptionExtension;

class HttpNotSuccess implements Exception {

  const HttpNotSuccess(this.statusCode, this.message);

  final int statusCode;
  final String message;

  factory HttpNotSuccess.dioThrow(DioError e) => HttpNotSuccess(
    Option.fromNullable(e.response)
      .map((res) => res.statusCode!)
      .getOrElse(() => 0),
    Option.fromNullable(e.response)
      .map((res) => res.data['error'])
      .getOrElse(() => 'Server error, check your internet connection')
  );
}