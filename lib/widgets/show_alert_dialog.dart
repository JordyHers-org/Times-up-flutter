// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/widgets/jh_custom_raised_button.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';

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
      content: Container(
        height: 160,
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(LineAwesomeIcons.info),
              JHDisplayText(
                text: title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              JHDisplayText(
                text: content,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ).vP16,
              const Spacer(),
            ],
          ).p(10),
        ),
      ),
      actions: [
        if (cancelActionText != null)
          JHCustomRaisedButton(
            width: 100,
            height: 40,
            onPressed: () => Navigator.of(context).pop(),
            color: CustomColors.indigoDark,
            child: JHDisplayText(
              text: cancelActionText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        JHCustomRaisedButton(
          width: 100,
          height: 40,
          onPressed: () => Navigator.of(context).pop(true),
          color: Colors.white,
          child: JHDisplayText(
            text: defaultActionText,
            style: const TextStyle(color: Colors.indigo),
          ),
        ),
      ],
    ),
  );

  return value as bool;
}
