import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/common_widgets/jh_internet_connection_widget.dart';
import 'package:times_up_flutter/services/internet_connectivity_service.dart';

import '../../services/shared_preferences.dart';
import '../landing_page.dart';
import '../splash/splash_screen.dart';

// ignore: must_be_immutable
class ScreensController extends StatefulWidget {
  const ScreensController({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  bool? _isVisited;

  Future<void> _setFlagValue() async {
    final isVisited = await SharedPreference().getVisitingFlag();
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
    return Scaffold(
      body: Stack(
        children: [
          if (_isVisited == null)
            const CircularProgressIndicator()
          else if (_isVisited!)
            const LandingPage()
          else
            const SplashScreen(),
          Consumer<InternetConnectivityService>(builder: (_, value, __) {
            return Container(
              margin: const EdgeInsets.only(bottom: 32),
              alignment: Alignment.bottomCenter,
              child: JHInternetConnectionWidget(
                internetConnected: value.isInternetConnected,
              ),
            );
          }),
        ],
      ),
    );
  }
}
