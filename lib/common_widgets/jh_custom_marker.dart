import 'package:flutter/material.dart';

class JHCustomMarker extends StatelessWidget {

  const JHCustomMarker({Key? key, required this.markerUrl}) : super(key: key);
  final String markerUrl;

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
