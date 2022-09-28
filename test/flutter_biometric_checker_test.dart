import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_biometric_checker/flutter_biometric_checker.dart';
import 'package:flutter_biometric_checker/flutter_biometric_checker_platform_interface.dart';
import 'package:flutter_biometric_checker/flutter_biometric_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBiometricCheckerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBiometricCheckerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBiometricCheckerPlatform initialPlatform = FlutterBiometricCheckerPlatform.instance;

  test('$MethodChannelFlutterBiometricChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBiometricChecker>());
  });

  test('getPlatformVersion', () async {
    FlutterBiometricChecker flutterBiometricCheckerPlugin = FlutterBiometricChecker();
    MockFlutterBiometricCheckerPlatform fakePlatform = MockFlutterBiometricCheckerPlatform();
    FlutterBiometricCheckerPlatform.instance = fakePlatform;

    expect(await flutterBiometricCheckerPlugin.getPlatformVersion(), '42');
  });
}
