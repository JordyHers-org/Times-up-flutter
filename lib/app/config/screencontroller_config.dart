import 'package:flutter/material.dart';
import 'package:times_up_flutter/app/landing_page.dart';
import 'package:times_up_flutter/app/splash/splash_screen.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';

class ScreensController extends StatefulWidget {
  const ScreensController({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  bool? _hasVisited;

  Future<void> _setFlagValue() async {
    final isVisited = await SharedPreference().getVisitingFlag();
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
        return const LandingPage();
      case false:
        return const SplashScreen();
      default:
        return const CircularProgressIndicator();
    }
  }
}
