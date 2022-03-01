
import 'package:flutter/material.dart';
import 'dart:async';


import 'package:flutter_animated_progress/flutter_animated_progress.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Rx<double> value = Rx(0);
  @override
  void initState() {
    super.initState();
    changeValue();
  }

changeValue() async {
    await Future.delayed(const Duration(seconds: 1), () => value.value=0.5);
    await Future.delayed(const Duration(seconds: 1), () => value.value=1);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: RxBuilder(
        (__) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: AnimatedLinearProgressIndicator(
                    value: value.value,
                    animationDuration: const Duration(seconds: 2),
                    minHeight: 7,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.grey[800],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: AnimatedCircularProgressIndicator(
                    value: value.value,
                    animationDuration: const Duration(seconds: 2),
                    strokeWidth: 7,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.grey[800],
                  ),
                ),
              ),
            ],
          );
        }
        ),
      ),
    );
  }
}
