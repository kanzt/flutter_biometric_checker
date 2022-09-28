import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_biometric_checker/flutter_biometric_checker_method_channel.dart';

void main() {
  MethodChannelFlutterBiometricChecker platform = MethodChannelFlutterBiometricChecker();
  const MethodChannel channel = MethodChannel('flutter_biometric_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
