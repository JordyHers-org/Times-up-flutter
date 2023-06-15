import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_progress_bar.dart';
import 'package:parental_control/theme/theme.dart';

import 'jh_display_text.dart';

class JHSummaryTile extends StatelessWidget {
  final String title;
  final String time;
  final double progressValue;
  const JHSummaryTile({
    Key? key,
    required this.title,
    required this.time,
    this.progressValue = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              JHDisplayText(
                text: title,
                style: TextStyle(color: CustomColors.indigoPrimary),
              )
            ],
          ).p16,
          Row(
            children: [
              JHDisplayText(
                text: time,
                style: TextStyle(color: Colors.black, fontSize: 35),
              ),
            ],
          ).p4,
          JHCustomProgressBar(progress: progressValue),
        ],
      ),
    );
  }
}
