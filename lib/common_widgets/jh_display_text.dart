import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class JHDisplayText extends StatelessWidget {

  const JHDisplayText({
    Key? key,
    required this.text,
    required this.style,
    this.fontSize,
    this.maxFontSize,
  }) : super(key: key);
  final String text;
  final TextStyle style;
  final double? fontSize;
  final double? maxFontSize;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      maxLines: 10,
      textScaleFactor: 1,
      minFontSize: fontSize ?? 13,
      maxFontSize: maxFontSize ?? 35,
    );
  }
}
