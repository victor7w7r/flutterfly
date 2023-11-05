// ignore_for_file: avoid_unused_constructor_parameters

import 'package:dio/dio.dart' show DioException;

final class HttpNotSuccess implements Exception {
  const HttpNotSuccess(this.statusCode, this.message);

  factory HttpNotSuccess.throwError(final Object e, final StackTrace s) =>
      HttpNotSuccess(
        (e as DioException).response?.statusCode ?? 0,
        ((e.response?.data ??
                {'error': 'Servidor caido o error en el servidor'})
            as Map<String, dynamic>)['error'],
      );

  final int statusCode;
  final String message;
}
