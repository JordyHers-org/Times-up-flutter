import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/size_config.dart';

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
              Text(
                "Time's Up",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  color: Colors.indigo.shade400,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.35),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Image.asset(
          image,
          height: getProportionateScreenHeight(220),
          width: getProportionateScreenWidth(135),
        ),
      ],
    );
  }
}
