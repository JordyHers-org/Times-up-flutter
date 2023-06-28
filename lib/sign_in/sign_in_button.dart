import 'package:design_library/design_library.dart';
import 'package:flutter/material.dart';

class SignInButton extends JHCustomRaisedButton {
  SignInButton({
    required String text,
    Key? key,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          child: JHDisplayText(
            text: text,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
          color: color ?? CustomColors.indigoLight,
          onPressed: onPressed ?? () {},
        );
}
