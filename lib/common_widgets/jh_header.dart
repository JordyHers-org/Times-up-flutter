import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

import 'jh_display_text.dart';

class JHHeader extends StatelessWidget {
  const JHHeader({
    Key? key,
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
          fontSize: 35,
          style: TextStyle(
            color: CustomColors.indigoDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        JHDisplayText(
          text: 'Welcome',
          fontSize: 35,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
