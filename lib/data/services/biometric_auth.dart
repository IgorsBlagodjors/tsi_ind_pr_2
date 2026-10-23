import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';

class BiometricAuth {
  BiometricAuth({LocalAuthentication? authentication})
    : _authentication = authentication ?? LocalAuthentication();

  final LocalAuthentication _authentication;

  Future<bool> authenticate() async {
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      throw const AuthFailure(
        'Biometric login is available on Android and iOS.',
      );
    }
    try {
      if (!await _authentication.canCheckBiometrics) {
        throw const AuthFailure(
          'Biometrics are unavailable. Use your password.',
        );
      }
      if ((await _authentication.getAvailableBiometrics()).isEmpty) {
        throw const AuthFailure(
          'Set up fingerprint or face recognition in your device settings first.',
        );
      }
      return await _authentication.authenticate(
        localizedReason: 'Verify your identity to access your saved account',
        biometricOnly: true,
      );
    } on LocalAuthException catch (error) {
      switch (error.code) {
        case LocalAuthExceptionCode.userCanceled:
        case LocalAuthExceptionCode.systemCanceled:
        case LocalAuthExceptionCode.userRequestedFallback:
          return false;
        case LocalAuthExceptionCode.temporaryLockout:
        case LocalAuthExceptionCode.biometricLockout:
          throw const AuthFailure(
            'Biometrics are locked. Use your password or try again later.',
          );
        case LocalAuthExceptionCode.noBiometricsEnrolled:
        case LocalAuthExceptionCode.noCredentialsSet:
          throw const AuthFailure(
            'Set up biometrics in your device settings first.',
          );
        default:
          throw const AuthFailure(
            'Biometrics are unavailable. Use your password.',
          );
      }
    }
  }

  Future<void> cancel() async {
    await _authentication.stopAuthentication();
  }
}
