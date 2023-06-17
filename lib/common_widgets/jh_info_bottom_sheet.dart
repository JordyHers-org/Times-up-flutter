import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_display_text.dart';
import 'package:parental_control/common_widgets/jh_header_widget.dart';
import 'package:parental_control/theme/theme.dart';

class JHBottomSheet extends StatelessWidget {
  final String message;
  final Widget child;
  const JHBottomSheet({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView(
        physics: ScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  )
                ],
              ).p8,
              HeaderWidget(
                title: 'Discover new tips',
                subtitle: 'Find out what you may not know yet',
              ).p8,
              Container(
                child: child,
                height: 200,
              ).p16,
              Container(
                child: JHDisplayText(
                  text: message,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: CustomColors.indigoLight,
                  ),
                ),
              ).hP50,
            ],
          )
        ],
      ),
    );
  }
}
