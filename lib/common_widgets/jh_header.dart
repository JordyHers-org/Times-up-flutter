import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

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
        Text(
          'Hello 👋',
          style: TextStyle(
            fontSize: 35,
            color: CustomColors.indigoDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: 35,
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
