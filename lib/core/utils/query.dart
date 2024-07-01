import 'dart:async' show FutureOr;

import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart' show Query, QueryBuilder;

final class BaseQueryBuilder<T, U> extends StatelessWidget {
  const BaseQueryBuilder(
    this.queryKey,
    this.queryFn, {
    required this.loading,
    required this.error,
    required this.success,
    this.def,
    this.queryAccess,
    super.key,
    this.mockError = false,
  });

  final String queryKey;
  final FutureOr<T?> Function() queryFn;
  final void Function(Query<T, U> query)? queryAccess;
  final Widget Function() loading;
  final Widget Function(Query<T, U> query, U? err) error;
  final Widget Function(Query<T, U> query, T value) success;
  final T? def;
  final bool mockError;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      QueryBuilder<T, U>(
        queryKey,
        queryFn,
        initial: def,
        builder: (final _, final query) {
          queryAccess?.call(query);
          if (query.isLoading || !query.hasData) return loading();
          if (query.hasError || mockError) {
            return error(query, mockError ? null : query.error as U);
          }
          if (def != null && (query.data as T) == def) return loading();
          return success(query, query.data as T);
        },
      );
}
