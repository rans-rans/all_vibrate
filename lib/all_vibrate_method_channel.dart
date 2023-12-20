import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'all_vibrate_platform_interface.dart';

/// An implementation of [AllVibratePlatform] that uses method channels.
class MethodChannelAllVibrate extends AllVibratePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('all_vibrate');

  @override
  Future<void> simpleVibrate({
    required int period,
    required int amplitude,
  }) async {
    return await methodChannel.invokeMethod(
      "simple_vibrate",
      {
        "milliseconds": period,
        "amplitude": amplitude,
      },
    );
  }

  @override
  Future<void> waveForm({
    required List<int> timings,
    required List<int> amplitudes,
  }) async {
    if (timings.any((item) => item < 0) || amplitudes.any((item) => item < 0)) {
      throw Exception("Negative number not accepted");
    }
    return await methodChannel.invokeMethod(
      "wave_form",
      {
        "timings": timings,
        "amplitudes": amplitudes,
      },
    );
  }
}
