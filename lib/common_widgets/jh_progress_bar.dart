import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;

  const CustomProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.greenPrimary,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    ).hP8;
  }
}
