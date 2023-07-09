import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<bool> getVisitingFlag() async {
    final preferences = await SharedPreferences.getInstance();
    final alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  Future<bool> getParentOrChild() async {
    final preferences = await SharedPreferences.getInstance();
    final isParent = preferences.getBool('isParent') ?? true;
    return isParent;
  }

  Future<bool> getDisplayShowCase() async {
    final preferences = await SharedPreferences.getInstance();
    final displayShowCase = preferences.getBool('displayShowCase') ?? false;
    return displayShowCase;
  }

  Future<void> setVisitingFlag() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', true);
  }

  Future<void> setParentDevice() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', true);
  }

  Future<void> setChildDevice() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', false);
  }

  Future<bool> setDisplayShowCase() async {
    final preferences = await SharedPreferences.getInstance();
    final status = await preferences.setBool('displayShowCase', true);
    return status;
  }
}
