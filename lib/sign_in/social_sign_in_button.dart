import 'package:design_library/design_library.dart';
import 'package:flutter/material.dart';

class SocialSignInButton extends JHCustomRaisedButton {
  SocialSignInButton({
    required String assetName,
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
              Image.asset(assetName),
              JHDisplayText(
                text: text,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              Opacity(
                opacity: 0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          color: color ?? Colors.indigo,
          onPressed: onPressed ?? () {},
        );
}
