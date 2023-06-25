import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

class JHBatteryWidget extends StatelessWidget {
  final double? level;
  const JHBatteryWidget({Key? key, this.level});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Container(
              height: 20,
              margin: EdgeInsets.all(1),
              width: (level!.clamp(0, 1) * 46),
              decoration: BoxDecoration(
                color: CustomColors.greenPrimary,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${(level! * 100).toInt()} %',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
