import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectivityService extends ChangeNotifier {
  bool? isInternetConnected = true;
  bool isDialogVisible = false;
  Stream<InternetConnectionStatus> connectivityStream =
      InternetConnectionChecker().onStatusChange;

  Future<void> getInitialConnectionStatus() async {
    isInternetConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  Future<void> checkConnectionStatus() async {
    connectivityStream.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        isInternetConnected = null;
        notifyListeners();
        Future.delayed(const Duration(seconds: 2), () {
          isInternetConnected = true;
          notifyListeners();
        });
      } else {
        isInternetConnected = false;
        notifyListeners();
      }
    });
  }
}
