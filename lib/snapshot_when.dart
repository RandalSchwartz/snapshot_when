import 'package:flutter/material.dart';

extension SnapshotWhen<T, R> on AsyncSnapshot<T> {
  R when({
    required R Function(T data) data,
    required R Function(Object error, StackTrace stackTrace) error,
    required R Function() loading,
  }) =>
      switch (this) {
        AsyncSnapshot(hasData: true, data: T d) => data(d),
        AsyncSnapshot(
          hasError: true,
          error: Object e,
          stackTrace: StackTrace s
        ) =>
          error(e, s),
        _ => loading(),
      };
}

extension SnapshotWhenWidget<T> on AsyncSnapshot<T> {
  Widget whenWidget({
    Widget Function(T data)? data,
    Widget Function(Object error, StackTrace stackTrace)? error,
    Widget Function()? loading,
  }) =>
      when(
        data: data ?? (d) => Text('$d'),
        error: error ?? (e, s) => Error.throwWithStackTrace(e, s),
        loading: loading ?? () => const CircularProgressIndicator.adaptive(),
      );
}
