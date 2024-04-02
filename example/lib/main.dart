import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_animated_progress/flutter_animated_progress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  @override
  void initState() {
    super.initState();
    changeValue();
  }

  changeValue() async {
    await Future.delayed(
        const Duration(seconds: 1), () => valueNotifier.value = 0);
    await Future.delayed(
        const Duration(seconds: 1), () => valueNotifier.value = 0.5);
    await Future.delayed(
        const Duration(seconds: 1), () => valueNotifier.value = 1);
    changeValue();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (context,double value, child) {
                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: AnimatedLinearProgressIndicator(
                          value: value,
                          animationDuration: const Duration(seconds: 2),
                          minHeight: 7,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.red),
                          backgroundColor: Colors.grey[800],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: AnimatedCircularProgressIndicator(
                          value: value,
                          animationDuration: const Duration(seconds: 2),
                          strokeWidth: 7,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.red),
                          backgroundColor: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
