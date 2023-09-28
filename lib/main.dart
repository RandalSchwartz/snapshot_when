import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final counterStream = () async* {
    await Future.delayed(const Duration(seconds: 5));
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: counterStream,
          builder: (context, snapshot) {
            debugPrint('$snapshot');
            return snapshot.when(
              data: (d) => Text('$d'),
              error: (e, s) => Error.throwWithStackTrace(e, s),
              loading: () => const CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    ));
  }
}

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
