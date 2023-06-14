import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/jh_info_box.dart';
import 'package:parental_control/theme/theme.dart';

class InfoRow extends StatelessWidget {
  final IconData icon_1;
  final IconData icon_2;
  const InfoRow({
    Key? key,
    required this.icon_1,
    required this.icon_2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InfoBox(
          onPress: null,
          icon: icon_1,
          iconColor: CustomColors.indigoDark,
          child: SizedBox(
            width: 150,
            child: Text(
              ' Lorem ipsum dolor sit amet, consectetuer '
              'adipiscing elit.Aenean commodo ligula eget dolor. ',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        InfoBox(
          onPress: null,
          icon: icon_2,
          iconColor: CustomColors.indigoDark,
          child: SizedBox(
            width: 150,
            child: Text(
              ' Lorem ipsum dolor sit amet, consectetuer '
              ' .Aenean commodo ligula eget dolor.  ',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
