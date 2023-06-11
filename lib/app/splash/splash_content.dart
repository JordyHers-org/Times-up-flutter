import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/autosize_text.dart';
import 'package:parental_control/theme/theme.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text, title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DisplayText(
                text: title,
                fontSize: 35,
                style: TextStyle(
                  color: CustomColors.indigoDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              DisplayText(
                text: text,
                fontSize: 17,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Icon(
                  icon,
                  size: 250,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
