# All Vibrate Package

The `all_vibrate` class provides methods for invoking a method channel to control phone vibrations in android.

## Getting Started

1. Add `all_vibrate` to the dependencies section of pubspec.yaml.

2.Import package

```

import 'package:all_vibrate/all_vibrate.dart';

```

## Methods

#### simpleVibrate

This method communicates with the native platform to trigger a vibration.

- Parameters:
  - period: The duration of the vibration in milliseconds.
  - amplitude: The amplitude of the vibration. Should be an integer value.

```

    await allVibrate.simpleVibrate(period: 500, amplitude: 50);

```

This will trigger a vibration for 500 milliseconds with an amplitude of 50
...

#### waveform

This method is used to trigger a custom vibration.

- Parameters:
  - timimgs: The duration of the vibration in milliseconds.
  - amplitude: The amplitude of the vibration. Should be an integer value.

```

    allVibrate.waveForm(timings: [200, 300, 400], amplitudes: [50, 75, 100]);

```

Vibrate 200ms with amplitude 50, next 300ms with amplitude 75 and so on

### Android

No configuration needed

### IOS

Coming soon
