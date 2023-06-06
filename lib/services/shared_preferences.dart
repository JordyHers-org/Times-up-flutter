import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  ///get Visting Flag on first launch
  Future<bool> getVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    var alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  Future<bool> getParentOrChild() async {
    var preferences = await SharedPreferences.getInstance();
    var isParent = preferences.getBool('isParent') ?? true;
    return isParent;
  }

  Future<bool> getDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var displayShowCase = preferences.getBool('displayShowCase') ?? false;
    return displayShowCase;
  }

  void setVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', true);
  }

  void setParentDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', true);
  }

  void setChildDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', false);
  }

  Future<bool> setDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var status = await preferences.setBool('displayShowCase', true);
    return status;
  }
}
