import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHBottomSheet extends StatelessWidget {
  const JHBottomSheet({
    required this.message,
    Key? key,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView(
        physics: const ScrollPhysics(),
        children: [
          Column(
            children: [
              JHDisplayText(
                text: message,
                maxLines: 250,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: CustomColors.indigoLight,
                ),
              ).hP(50),
            ],
          ),
        ],
      ),
    );
  }
}
