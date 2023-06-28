import 'package:flutter/material.dart';

class JHCustomRaisedButton extends StatelessWidget {
  const JHCustomRaisedButton({
    required this.child,
    required this.onPressed,
    required this.color,
    Key? key,
    this.width,
    this.borderRadius = 4.0,
    this.height = 55.0,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double? width;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.indigo,
          backgroundColor: color,
          disabledBackgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
