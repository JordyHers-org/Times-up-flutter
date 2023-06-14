import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_size_config.dart';
import 'package:parental_control/theme/theme.dart';

class JHCustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Function() onPress;
  final String title;
  const JHCustomButton({
    Key? key,
    required this.backgroundColor,
    required this.onPress,
    required this.title,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JHSizeConfig().init(context);
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(width: 1.5, color: borderColor),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.95,
            JHSizeConfig.screenHeight! * 0.07,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(13),
            color: textColor,
          ),
        ),
      ),
    ).p4;
  }
}
