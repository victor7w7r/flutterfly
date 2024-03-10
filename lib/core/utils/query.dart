import 'dart:async' show FutureOr;

import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart' show Query, QueryBuilder;

class BaseQueryBuilder<T, U> extends StatelessWidget {
  const BaseQueryBuilder(
    this.queryKey,
    this.queryFn, {
    required this.loading,
    required this.error,
    required this.success,
    this.initial,
    this.queryAccess,
    super.key,
  });

  final String queryKey;
  final FutureOr<T?> Function() queryFn;
  final void Function(Query<T, U>)? queryAccess;
  final Widget Function() loading;
  final Widget Function(Query<T, U>, U) error;
  final Widget Function(Query<T, U>, T) success;
  final T? initial;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      QueryBuilder<T, U>(
        queryKey,
        queryFn,
        initial: initial,
        builder: (final _, final query) {
          queryAccess?.call(query);
          if (query.isLoading || !query.hasData) return loading();
          if (query.hasError) return error(query, query.error as U);
          return success(query, query.data as T);
        },
      );
}
