import 'package:flutter/foundation.dart';

/// Tracks explicit authentication for this app run, independently of Firebase's
/// persisted session. Restored credentials alone must not unlock protected routes.
class AppAccess extends ChangeNotifier {
  static final instance = AppAccess();
  String? _userId;

  bool allows(String? userId) => userId != null && _userId == userId;

  void unlock(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void lock() {
    _userId = null;
    notifyListeners();
  }
}
