import 'all_vibrate_platform_interface.dart';

/// The `AllVibrate` class provides methods to control phone vibrations.
///
/// Example:
/// ```dart
/// // Create an instance of AllVibrate.
/// var allVibrate = AllVibrate();
///
/// // Vibrate the phone for 500 milliseconds with an amplitude of 50.
/// await allVibrate.simpleVibrate(period: 500, amplitude: 50);
///
/// // Vibrate the phone with a specified waveform pattern.
/// await allVibrate.waveForm(timings: [200, 300, 400], amplitudes: [50, 75, 100]);
/// ```
class AllVibrate {
  /// Invokes a method channel to vibrate the phone with a specified duration and amplitude.
  ///
  /// This method communicates with the native platform to trigger a vibration.
  ///
  /// - Parameters:
  ///   - period: The duration of the vibration in milliseconds.
  ///   - amplitude: The amplitude of the vibration. Should be an integer value.
  ///
  /// - Returns: A [Future] that completes when the vibration is initiated.
  ///
  /// Example:
  /// ```dart
  /// // Vibrate the phone for 500 milliseconds with an amplitude of 50.
  /// await allVibrate.simpleVibrate(period: 500, amplitude: 50);
  /// ```
  Future<void> simpleVibrate({
    required int period,
    required int amplitude,
  }) {
    return AllVibratePlatform.instance.simpleVibrate(
      amplitude: amplitude,
      period: period,
    );
  }

  /// Invokes a method channel to vibrate the phone with a specified waveform pattern.
  ///
  /// This method communicates with the native platform to trigger a vibration pattern
  /// based on the provided timings and amplitudes. The lengths of the timings and
  /// amplitudes lists must be equal, or an exception will be thrown.
  ///
  /// - Parameters:
  ///   - timings: A list of integers representing the duration of each vibration segment
  ///     in milliseconds.
  ///   - amplitudes: A list of integers representing the amplitude of each respective
  ///     vibration segment. The length of this list must match the length of the timings list.
  ///
  /// - Returns: A [Future] that completes when the waveform vibration is initiated.
  ///
  /// Example:
  /// ```dart
  /// await allVibrate.waveForm(timings: [200, 300, 400], amplitudes: [50, 75, 100]);
  /// ```
  Future<void> waveForm({
    required List<int> timings,
    required List<int> amplitudes,
  }) {
    if (timings.length != amplitudes.length) {
      throw ArgumentError(
          '''Lengths of timings and amplitudes lists must be equal.
      Length of timings is ${timings.length} and length of amplitudes is ${amplitudes.length}
      ''');
    }

    return AllVibratePlatform.instance.waveForm(
      amplitudes: amplitudes,
      timings: timings,
    );
  }
}
