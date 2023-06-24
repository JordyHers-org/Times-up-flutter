import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

class JHBatteryWidget extends StatelessWidget {
  final double? level;
  const JHBatteryWidget({Key? key, this.level});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(1),
              width: (level!.clamp(0, 1) * 96),
              decoration: BoxDecoration(
                color: CustomColors.greenPrimary,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                color: Colors.black,
                width: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
