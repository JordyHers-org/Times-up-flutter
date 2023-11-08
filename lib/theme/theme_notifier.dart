import 'package:flutter/material.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> initThemeMode() async {
    _isDarkMode = await CacheService.getThemeMode();
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    CacheService.setTheDarkTheme(value: _isDarkMode);
    notifyListeners();
  }
}
