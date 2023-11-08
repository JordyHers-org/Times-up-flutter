import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static Future<bool> getVisitingFlag() async {
    final preferences = await SharedPreferences.getInstance();
    final alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  static Future<bool> getParentOrChild() async {
    final preferences = await SharedPreferences.getInstance();
    final isParent = preferences.getBool('isParent') ?? true;
    return isParent;
  }

  static Future<bool> getDisplayShowCase() async {
    final preferences = await SharedPreferences.getInstance();
    final displayShowCase = preferences.getBool('displayShowCase') ?? false;
    return displayShowCase;
  }

  static Future<bool> getThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final darkMode = preferences.getBool('isDarkMode') ?? false;
    return darkMode;
  }

  static Future<void> setVisitingFlag() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', true);
  }

  static Future<void> setParentDevice() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', true);
  }

  static Future<void> setChildDevice() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', false);
  }

  static Future<bool> setDisplayShowCase() async {
    final preferences = await SharedPreferences.getInstance();
    final status = await preferences.setBool('displayShowCase', true);
    return status;
  }

  static Future<bool> setTheDarkTheme({required bool value}) async {
    final preferences = await SharedPreferences.getInstance();
    final status = await preferences.setBool('isDarkMode', value);
    return status;
  }
}
