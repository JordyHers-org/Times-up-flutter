import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_header_widget.dart';
import 'package:times_up_flutter/common_widgets/jh_info_bottom_sheet.dart';
import 'package:times_up_flutter/common_widgets/jh_info_box.dart';
import 'package:times_up_flutter/common_widgets/show_bottom_sheet.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/utils/data.dart';

class JHInfoRow extends StatelessWidget {
  const JHInfoRow({
    required this.icon_1,
    required this.icon_2,
    required this.dataOne,
    required this.dataTwo,
    Key? key,
  }) : super(key: key);
  final IconData icon_1;
  final IconData icon_2;
  final InfoData dataOne;
  final InfoData dataTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InfoBox(
            onPress: () => showCustomBottomSheet(
              context,
              verticalPadding: 80,
              title: const HeaderWidget(
                title: 'Discover new tips',
                subtitle: 'Find out what you may not know yet',
              ).p8,
              child: JHBottomSheet(
                message: dataOne.content,
              ),
            ),
            icon: icon_1,
            iconColor: CustomColors.indigoDark,
            child: JHDisplayText(
              text: dataOne.title,
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
              verticalPadding: 80,
              title: const HeaderWidget(
                title: 'Discover new tips',
                subtitle: 'Find out what you may not know yet',
              ).p8,
              child: JHBottomSheet(
                message: dataTwo.content,
              ),
            ),
            icon: icon_2,
            iconColor: CustomColors.indigoDark,
            child: JHDisplayText(
              text: dataTwo.title,
              fontSize: 12,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }
}
