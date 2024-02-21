import 'package:dio/dio.dart' show DioException;

final class HttpNotSuccess implements Exception {
  const HttpNotSuccess(this.statusCode, this.message);

  // ignore: avoid_unused_constructor_parameters
  factory HttpNotSuccess.throwError(final Object e, final StackTrace s) =>
      HttpNotSuccess(
        (e as DioException).response?.statusCode ?? 0,
        ((e.response?.data ?? {'error': 'Error in the server'})
            as Map<String, dynamic>)['error'],
      );

  final int statusCode;
  final String message;
}
