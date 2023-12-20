import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'all_vibrate_method_channel.dart';

abstract class AllVibratePlatform extends PlatformInterface {
  /// Constructs a AllVibratePlatform.
  AllVibratePlatform() : super(token: _token);

  static final Object _token = Object();

  static AllVibratePlatform _instance = MethodChannelAllVibrate();

  /// The default instance of [AllVibratePlatform] to use.
  ///
  /// Defaults to [MethodChannelAllVibrate].
  static AllVibratePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AllVibratePlatform] when
  /// they register themselves.
  static set instance(AllVibratePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> simpleVibrate({
    required int period,
    required int amplitude,
  });

  Future<void> waveForm({
    required List<int> timings,
    required List<int> amplitudes,
  });
}
