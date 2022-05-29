import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  ///get Visting Flag on first launch
  getVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    var alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  getParentOrChild() async {
    var preferences = await SharedPreferences.getInstance();
    var isParent = preferences.getBool('isParent') ?? true;
    return isParent;
  }

  getDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var displayShowCase = preferences.getBool('displayShowCase') ?? false;
    return displayShowCase;
  }

  setVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', true);
  }

  setParentDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', true);
  }

  setChildDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', false);
  }

  Future<bool> setDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var status = await preferences.setBool('displayShowCase', true);
    return status;
  }
}
