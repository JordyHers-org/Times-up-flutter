import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_info_bottom_sheet.dart';
import 'package:parental_control/common_widgets/jh_info_box.dart';
import 'package:parental_control/common_widgets/show_bottom_sheet.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:parental_control/utils/data.dart';

import 'jh_display_text.dart';

class JHInfoRow extends StatelessWidget {
  final IconData icon_1;
  final IconData icon_2;
  final String text_1;
  final String text_2;
  const JHInfoRow({
    Key? key,
    required this.icon_1,
    required this.icon_2,
    required this.text_1,
    required this.text_2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InfoBox(
          onPress: () => showCustomBottomSheet(
            context,
            child: JHBottomSheet(
              message: text_1,
              child: Png.info1,
            ),
          ),
          icon: icon_1,
          iconColor: CustomColors.indigoDark,
          child: SizedBox(
            width: 150,
            child: Text(
              text_1,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
        InfoBox(
          onPress: () => showCustomBottomSheet(
            context,
            child: JHBottomSheet(
              message: text_2,
              child: Png.info2,
            ),
          ),
          icon: icon_2,
          iconColor: CustomColors.indigoDark,
          child: SizedBox(
            width: 136,
            child: JHDisplayText(
              text: text_2,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }
}
