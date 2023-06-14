import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class JHDisplayText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double? fontSize;

  const JHDisplayText({
    Key? key,
    required this.text,
    required this.style,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      maxLines: 10,
      minFontSize: fontSize ?? 10,
      maxFontSize: fontSize ?? 21,
    );
  }
}
