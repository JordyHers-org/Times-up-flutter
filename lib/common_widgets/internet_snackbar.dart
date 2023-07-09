import 'package:flutter/material.dart';

class InternetSnackBar extends StatelessWidget {
  bool isInternetConnected;
  InternetSnackBar({
    required this.isInternetConnected,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content:
            Text('Internet is ${isInternetConnected ? 'online' : 'offline'}'));
  }
}
