import 'package:flutter/material.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHBatteryWidget extends StatelessWidget {
  const JHBatteryWidget({Key? key, this.level}) : super(key: key);
  final double? level;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Container(
              height: 20,
              margin: const EdgeInsets.all(1),
              width: level!.clamp(0, 1) * 46,
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
              child: Text(
                '${(level! * 100).toInt()} %',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
