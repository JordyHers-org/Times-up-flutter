import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/progress_bar.dart';
import 'package:parental_control/theme/theme.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Today, April 6 ',
                style: TextStyle(color: CustomColors.indigoPrimary),
              )
            ],
          ).p16,
          Row(
            children: [
              Text(
                '1 hr 5 min',
                style: TextStyle(color: Colors.black, fontSize: 35),
              ),
            ],
          ).p4,
          CustomProgressBar(progress: 0.75),
        ],
      ),
    );
  }
}
