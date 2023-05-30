import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

class FeatureWidget extends StatelessWidget {
  final String? title;
  final Widget? child;
  final IconData? icon;

  const FeatureWidget({Key? key, this.title, this.icon, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: CustomColors.indigoDark,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: CustomColors.indigoPrimary.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.symmetric(horizontal: 85.0, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          if (child != null) child ?? SizedBox.shrink(),
          title != null
              ? Text(
                  title!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: CustomColors.indigoLight),
                )
              : SizedBox.shrink(),
          Spacer(),
          if (icon != null)
            Icon(
              icon,
              size: 22,
            ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
