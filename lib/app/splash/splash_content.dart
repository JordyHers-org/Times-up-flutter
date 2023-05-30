import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/autosize_text.dart';
import 'package:parental_control/common_widgets/size_config.dart';
import 'package:parental_control/theme/theme.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DisplayText(
                text: "Time's Up",
                fontSize: 35,
                style: TextStyle(
                  color: CustomColors.indigoDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: DisplayText(
                  text: text,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      height: 1.5),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(150),
          width: getProportionateScreenWidth(135),
        ),
      ],
    );
  }
}
