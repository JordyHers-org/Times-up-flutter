import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  final String markerUrl;

  const CustomMarker({Key? key, required this.markerUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      markerUrl,
      height: 32,
      width: 32,
      color: Colors.indigo,
    );
  }
}
