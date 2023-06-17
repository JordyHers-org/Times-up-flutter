import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_custom_raised_button.dart';
import 'package:parental_control/theme/theme.dart';

import '../common_widgets/jh_display_text.dart';

class SignInButton extends JHCustomRaisedButton {
  SignInButton({
    required String text,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
    Key? key,
  }) : super(
          child: JHDisplayText(
            text: text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color ?? CustomColors.indigoLight,
          onPressed: onPressed ?? () {},
        );
}
