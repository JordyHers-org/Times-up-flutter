import 'package:flutter/material.dart';

Future<void> showCustomBottomSheet(
  BuildContext context, {
  required Widget child,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return child;
    },
  );
}
