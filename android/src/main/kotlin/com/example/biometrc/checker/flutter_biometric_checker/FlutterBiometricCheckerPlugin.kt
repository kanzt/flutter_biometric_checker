package com.example.biometrc.checker.flutter_biometric_checker

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterBiometricCheckerPlugin */
class FlutterBiometricCheckerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_biometric_checker")
        channel.setMethodCallHandler(this)
        mContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "isFingerprintAvailable" -> {
                isFingerprintAvailable(result);
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * ขอแค่ลงทะเบียนเอาไว้ถือว่าใช้งานได้
     */
    private fun isFingerprintAvailable(@NonNull result: Result) {
        val biometricManager = BiometricManager.from(mContext)

        if (biometricManager.canAuthenticate(BIOMETRIC_STRONG) == BiometricManager.BIOMETRIC_SUCCESS) {
            Log.d(
                FlutterBiometricCheckerPlugin::class.java.simpleName,
                "App can authenticate using biometrics."
            )

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val isHasFingerprint =
                    mContext.packageManager.hasSystemFeature(PackageManager.FEATURE_FINGERPRINT);
                if (isHasFingerprint) {
                    Log.d(
                        FlutterBiometricCheckerPlugin::class.java.simpleName,
                        "Fingerprint is available"
                    )
                    result.success(isHasFingerprint)
                    return
                }
            }
        }

        Log.d(
            FlutterBiometricCheckerPlugin::class.java.simpleName,
            "Fingerprint is not available"
        )

        result.success(false)
    }
}
