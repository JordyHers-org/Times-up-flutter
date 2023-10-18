import 'package:flutter/material.dart';

Future<void> showCustomBottomSheet(
  BuildContext context, {
  required Widget child,
  required AnimationController animationController,
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
      return BottomSheet(
        animationController: animationController,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        showDragHandle: true,
        dragHandleSize: const Size(70, 10),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onClosing: () => Navigator.of(context).pop(),
        builder: (_) => child,
      );
    },
  );
}
