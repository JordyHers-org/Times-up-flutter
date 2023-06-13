import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/size_config.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function() onPress;
  final String title;
  const CustomButton({
    Key? key,
    required this.color,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(width: 1.5, color: Colors.transparent),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.95,
            SizeConfig.screenHeight! * 0.07,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(11),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
