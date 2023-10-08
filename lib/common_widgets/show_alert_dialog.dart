// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String defaultActionText,
  String? cancelActionText,
}) async {
  final value = await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(title),
      content: Text(content),
      actions: [
        if (cancelActionText != null)
          OutlinedButton(
            child: Text(
              cancelActionText,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(backgroundColor: Colors.indigo),
          child: Text(
            defaultActionText,
            style: TextStyle(
              color: Theme.of(context).indicatorColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );

  return value as bool;
}
