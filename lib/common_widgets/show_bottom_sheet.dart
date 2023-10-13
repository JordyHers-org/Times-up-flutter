import 'package:flutter/material.dart';
import 'package:times_up_flutter/theme/theme.dart';

Future<void> showCustomBottomSheet(
  BuildContext context, {
  required Widget child,
  Widget? title,
  double? verticalPadding,
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
      return Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
            ],
          ).p8,
          if (title != null)
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [title],
              ),
            ),
          Align(
            child: child,
          ).vTopP(verticalPadding ?? 0),
        ],
      );
    },
  );
}
