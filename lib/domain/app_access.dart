import 'package:flutter/foundation.dart';

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
