import 'package:flutter/material.dart';
import 'package:parental_control/app/splash/splash_screen.dart';
import 'package:parental_control/services/shared_preferences.dart';

import '../landing_page.dart';

// ignore: must_be_immutable
class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  bool? _isVisited;

  ///_setFlagValue for the user when he entered the app
  ///To Display a Splash Screen
  Future<void> _setFlagValue() async {
    var isVisited = await SharedPreference().getVisitingFlag();
    setState(() {
      _isVisited = isVisited;
    });
  }

  @override
  void initState() {
    _setFlagValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_isVisited) {
      case true:
        return LandingPage();
      case false:
        return SplashScreen();
      default:
        return CircularProgressIndicator();
    }
  }
}
