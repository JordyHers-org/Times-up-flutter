import 'package:flutter/material.dart';

class JHCustomMarker extends StatelessWidget {
  final String markerUrl;

  const JHCustomMarker({Key? key, required this.markerUrl}) : super(key: key);

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
