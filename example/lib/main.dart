import 'package:all_vibrate/all_vibrate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final vibrate = AllVibrate();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Simple vibrate'),
                onPressed: () {
                  vibrate.simpleVibrate(period: 1500, amplitude: 200);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  vibrate.waveForm(
                    timings: [102, 303, 983, 332],
                    amplitudes: [100, 150, 49, 100],
                  );
                },
                child: const Text('Waveform'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
