import 'package:firebase_auth/firebase_auth.dart';

String authErrorMessage(FirebaseAuthException error) {
  return switch (error.code) {
    'email-already-in-use' =>
      'This email is already registered. Please log in.',
    'invalid-email' => 'Enter a valid email address.',
    'weak-password' => 'Choose a stronger password (at least 6 characters).',
    'invalid-credential' ||
    'wrong-password' ||
    'user-not-found' => 'Incorrect email or password.',
    'user-disabled' => 'This account has been disabled.',
    'network-request-failed' => 'Check your internet connection and try again.',
    'too-many-requests' => 'Too many attempts. Please try again later.',
    'operation-not-allowed' =>
      'Email/password sign-in is not enabled in Firebase.',
    _ => 'Authentication failed (${error.code}). Please try again.',
  };
}
