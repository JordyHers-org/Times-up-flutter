import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHHeader extends StatelessWidget {
  const JHHeader({
    Key? key,
    this.fontSize = 35,
    this.maxFontSize = 35,
  }) : super(key: key);
  final double? fontSize;
  final double? maxFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
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
