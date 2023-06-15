import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

import 'jh_custom_raised_button.dart';
import 'jh_display_text.dart';

class FormSubmitButton extends JHCustomRaisedButton {
  FormSubmitButton({
    required String text,
    required VoidCallback onPressed,
    Color? color,
  }) : super(
          child: JHDisplayText(
              text: text, style: TextStyle(color: Colors.white, fontSize: 20),),
          height: 44.0,
          color: color ?? CustomColors.indigoDark,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
