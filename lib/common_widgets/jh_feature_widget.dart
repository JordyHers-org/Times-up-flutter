import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHFeatureWidget extends StatelessWidget {
  const JHFeatureWidget({
    Key? key,
    this.title,
    this.icon,
    this.child,
    this.subtitle,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final Widget? child;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: CustomColors.indigoLight,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: CustomColors.indigoPrimary.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: 200,
        child: Row(
          children: [
            const SizedBox(width: 10),
            if (child != null) child ?? const SizedBox.shrink(),
            if (child != null) const SizedBox(width: 20),
            if (title != null)
              JHDisplayText(
                text: title!,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: CustomColors.indigoDark,
                ),
              )
            else
              const SizedBox.shrink(),
            const Spacer(),
            if (icon != null)
              Icon(
                icon,
                size: 22,
                color: CustomColors.indigoDark,
              ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
