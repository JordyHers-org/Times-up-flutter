import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_custom_raised_button.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class SignInButton extends JHCustomRaisedButton {
  SignInButton({
    required String text,
    Key? key,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.email,
                color: Colors.white,
                size: 30,
              ),
              JHDisplayText(
                text: text,
                style: TextStyle(color: textColor, fontSize: 17),
              ),
              const SizedBox.shrink(),
            ],
          ),
          color: color ?? CustomColors.indigoLight,
          onPressed: onPressed ?? () {},
        );
}
