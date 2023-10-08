import 'package:flutter/material.dart';

Future<void> showCustomBottomSheet(
  BuildContext context, {
  required Widget child,
}) async {
  await showModalBottomSheet<Widget>(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return child;
    },
  );
}
