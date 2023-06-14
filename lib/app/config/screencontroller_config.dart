import 'package:flutter/material.dart';
import 'package:parental_control/app/landing_page.dart';
import 'package:parental_control/app/splash/splash_screen.dart';
import 'package:parental_control/services/shared_preferences.dart';

class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  bool? _hasVisited;

  Future<void> _setFlagValue() async {
    var isVisited = await SharedPreference().getVisitingFlag();
    setState(() {
      _hasVisited = isVisited;
    });
  }

  @override
  void initState() {
    _setFlagValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_hasVisited) {
      case true:
        return LandingPage();
      case false:
        return SplashScreen();
      default:
        return CircularProgressIndicator();
    }
  }
}
