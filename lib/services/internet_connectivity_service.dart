import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class InternetConnectivityService extends ChangeNotifier {
  bool? isInternetConnected = true;
  bool isDialogVisible = false;
  late StreamSubscription<InternetConnectionStatus> connectivityStream;
  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
      
  final Duration backOnlineDuration = const Duration(seconds: 2);

  Future<void> getInitialConnectionStatus() async {
    isInternetConnected = await internetConnectionChecker.hasConnection;
    notifyListeners();
  }

  Future<void> checkConnectionStatus() async {
    connectivityStream =
        internetConnectionChecker.onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        isInternetConnected = null;
        notifyListeners();
        Future.delayed(backOnlineDuration, () {
          isInternetConnected = true;
          notifyListeners();
        });
      } else {
        isInternetConnected = false;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    connectivityStream.cancel();
    super.dispose();
  }
}
