import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:internet_connectivity_checker/internet_connectivity_checker.dart';
import 'package:parental_control/app/splash/splash_screen.dart';
import 'package:parental_control/services/internet_service.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../landing_page.dart';

// ignore: must_be_immutable
class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  bool? _isVisited;
  bool? isInternetConnected;

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
    final internet = Provider.of<InternetService>(context, listen: false);

    if (internet.isInternetConnected != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Internet is ${Provider.of<InternetService>(context, listen: false).isInternetConnected! ? 'online' : 'offline'}'),
        ),
      );
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<InternetService>(context, listen: false)
                      .isInternetConnected !=
                  null &&
              true
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                    'Internet is ${Provider.of<InternetService>(context, listen: false).isInternetConnected! ? 'online' : 'offline'}'),
              ),
            )
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisited == null
        ? CircularProgressIndicator()
        : _isVisited!
            ? LandingPage()
            : SplashScreen();
  }
}
