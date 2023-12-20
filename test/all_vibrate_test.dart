import 'package:flutter_test/flutter_test.dart';

import 'package:all_vibrate/all_vibrate_platform_interface.dart';
import 'package:all_vibrate/all_vibrate_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAllVibratePlatform
    with MockPlatformInterfaceMixin
    implements AllVibratePlatform {
  @override
  Future<void> simpleVibrate({required int period, required int amplitude}) {
    throw UnimplementedError();
  }

  @override
  Future<void> waveForm({
    required List<int> timings,
    required List<int> amplitudes,
  }) {
    throw UnimplementedError();
  }
}

void main() {
  final AllVibratePlatform initialPlatform = AllVibratePlatform.instance;

  test('$MethodChannelAllVibrate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAllVibrate>());
  });

  test('getPlatformVersion', () async {
    MockAllVibratePlatform fakePlatform = MockAllVibratePlatform();
    AllVibratePlatform.instance = fakePlatform;
  });
}
