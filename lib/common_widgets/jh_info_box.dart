import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_size_config.dart';
import 'package:parental_control/theme/theme.dart';

typedef TriggerFunction = void Function()?;

class InfoBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final TriggerFunction onPress;

  const InfoBox({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.child,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JHSizeConfig().init(context);
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: JHSizeConfig.screenWidth! * 0.45,
        decoration: BoxDecoration(
          color: CustomColors.indigoLight.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: CustomColors.indigoLight.withOpacity(0.6),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ],
            ).p4,
            child.p16,
          ],
        ),
      ),
    );
  }
}
