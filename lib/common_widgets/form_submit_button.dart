import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

import 'custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton(
      {required String text, required VoidCallback onPressed, Color? color})
      : super(
            child:
                Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
            height: 44.0,
            color: color ?? CustomColors.indigoDark,
            borderRadius: 4.0,
            onPressed: onPressed);
}
