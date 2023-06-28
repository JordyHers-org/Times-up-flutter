import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_info_bottom_sheet.dart';
import 'package:times_up_flutter/common_widgets/jh_info_box.dart';
import 'package:times_up_flutter/common_widgets/show_bottom_sheet.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/utils/data.dart';

class JHInfoRow extends StatelessWidget {
  const JHInfoRow({
    required this.icon_1,
    required this.icon_2,
    required this.text_1,
    required this.text_2,
    Key? key,
  }) : super(key: key);
  final IconData icon_1;
  final IconData icon_2;
  final String text_1;
  final String text_2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InfoBox(
            onPress: () => showCustomBottomSheet(
              context,
              child: JHBottomSheet(
                message: text_1,
                child: Png.info1,
              ),
            ),
            icon: icon_1,
            iconColor: CustomColors.indigoDark,
            child: JHDisplayText(
              text: text_1,
              fontSize: 12,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InfoBox(
            onPress: () => showCustomBottomSheet(
              context,
              child: JHBottomSheet(
                message: text_2,
                child: Png.info2,
              ),
            ),
            icon: icon_2,
            iconColor: CustomColors.indigoDark,
            child: JHDisplayText(
              text: text_2,
              fontSize: 12,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }
}
