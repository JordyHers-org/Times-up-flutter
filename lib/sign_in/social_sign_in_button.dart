import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_custom_raised_button.dart';

import 'package:times_up_flutter/common_widgets/jh_display_text.dart';

class SocialSignInButton extends JHCustomRaisedButton {
  SocialSignInButton({Key? key, 
    required String assetName,
    required String text,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          key: key, child: Row(
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
