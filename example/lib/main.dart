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

  Future<void> changeValue() async {
    const values = [0.0, 0.5, 1.0]; // Define the sequence of values.
    while (mounted) { // Check if the widget is still in the widget tree.
      for (var value in values) {
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return; // Exit if the widget is no longer in the tree.
        valueNotifier.value = value;
      }
    }
  }


  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
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
              builder: (context, double value, child) {
                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: AnimatedLinearProgressIndicator(
                          value: value,
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
