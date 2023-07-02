import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_size_config.dart';
import 'package:times_up_flutter/theme/theme.dart';

typedef TriggerFunction = void Function()?;

class InfoBox extends StatelessWidget {
  const InfoBox({
    required this.icon,
    required this.iconColor,
    required this.child,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final TriggerFunction onPress;

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
