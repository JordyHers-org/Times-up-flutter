import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

class InfoBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Widget child;

  const InfoBox({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: CustomColors.indigoLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: CustomColors.indigoLight,
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
            ],
          ).p4,
          child.p16,
        ],
      ),
    ).p16;
  }
}
