
import 'flutter_biometric_checker_platform_interface.dart';

class FlutterBiometricChecker {
  Future<String?> getPlatformVersion() {
    return FlutterBiometricCheckerPlatform.instance.getPlatformVersion();
  }

  Future<bool?> isFingerprintAvailable(){
    return FlutterBiometricCheckerPlatform.instance.isFingerprintAvailable();
  }
}
