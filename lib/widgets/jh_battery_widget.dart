import 'package:flutter/material.dart';

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
                color: _setColor(level!),
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

  Color _setColor(double level) {
    if (level > 0.7) {
      return Colors.green;
    }
    if (level > 0.15 && level < 0.5) {
      return Colors.amber;
    }
    if (level < 0.15) {
      return Colors.red;
    }
    return Colors.green;
  }
}
