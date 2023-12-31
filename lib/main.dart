import 'package:flutter/material.dart';
import 'package:snapshot_when/snapshot_when.dart';

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
            return snapshot.whenWidget();
          },
        ),
      ),
    ));
  }
}
