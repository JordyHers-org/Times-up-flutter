import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

import 'jh_display_text.dart';

class JHHeader extends StatelessWidget {
  final double? fontSize;
  final double? maxFontSize;
  const JHHeader({
    Key? key,
    this.fontSize = 25,
    this.maxFontSize = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JHDisplayText(
          text: 'Hello 👋',
          fontSize: fontSize,
          maxFontSize: maxFontSize,
          style: TextStyle(
            color: CustomColors.indigoDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        JHDisplayText(
          text: 'Welcome',
          fontSize: fontSize,
          maxFontSize: maxFontSize,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
