import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_custom_raised_button.dart';

class SocialSignInButton extends JHCustomRaisedButton {
  SocialSignInButton({
    required String assetName,
    required String text,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          color: color ?? Colors.indigo,
          onPressed: onPressed ?? () {},
        );
}
