import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_biometric_checker_method_channel.dart';

abstract class FlutterBiometricCheckerPlatform extends PlatformInterface {
  /// Constructs a FlutterBiometricCheckerPlatform.
  FlutterBiometricCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterBiometricCheckerPlatform _instance = MethodChannelFlutterBiometricChecker();

  /// The default instance of [FlutterBiometricCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterBiometricChecker].
  static FlutterBiometricCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterBiometricCheckerPlatform] when
  /// they register themselves.
  static set instance(FlutterBiometricCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> isFingerprintAvailable() {
    throw UnimplementedError('isFingerprintAvailable() has not been implemented.');
  }
}
