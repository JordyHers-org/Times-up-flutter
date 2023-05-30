import 'package:flutter/material.dart';

class LoadingMap extends StatelessWidget {
  const LoadingMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: Colors.black.withOpacity(0.14)),
    );
  }
}
