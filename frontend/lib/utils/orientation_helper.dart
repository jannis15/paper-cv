import 'package:native_device_orientation/native_device_orientation.dart';

class OrientationHelper {
  static Future<NativeDeviceOrientation> getCameraOrientation() => NativeDeviceOrientationCommunicator().orientation(useSensor: false);

  static int getRotationAngle(NativeDeviceOrientation orientation) {
    switch (orientation) {
      case NativeDeviceOrientation.portraitUp:
        return 0;
      case NativeDeviceOrientation.portraitDown:
        return 180;
      case NativeDeviceOrientation.landscapeLeft:
        return -90;
      case NativeDeviceOrientation.landscapeRight:
        return 90;
      case NativeDeviceOrientation.unknown:
        throw Exception('Unknown orientation type.');
    }
  }
}
