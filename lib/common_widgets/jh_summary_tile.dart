import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_progress_bar.dart';
import 'package:times_up_flutter/common_widgets/jh_size_config.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHSummaryTile extends StatelessWidget {
  const JHSummaryTile({
    required this.title,
    required this.time,
    Key? key,
    this.progressValue = 75,
  }) : super(key: key);
  final String title;
  final String time;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    JHSizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.all(10),
      constraints: const BoxConstraints(
        maxHeight: 170,
        minHeight: 150,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              JHDisplayText(
                text: title,
                style: const TextStyle(color: Colors.indigo),
              ),
            ],
          ).p16,
          Row(
            children: [
              JHDisplayText(
                text: time,
                fontSize: 25,
                style: const TextStyle(),
              ),
            ],
          ).p16,
          JHCustomProgressBar(progress: progressValue / 100),
        ],
      ),
    );
  }
}
