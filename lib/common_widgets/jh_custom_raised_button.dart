import 'package:flutter/material.dart';

class JHCustomRaisedButton extends StatelessWidget {
  JHCustomRaisedButton({
    required this.child,
    required this.onPressed,
    required this.color,
    this.width,
    this.borderRadius = 4.0,
    this.height = 55.0,
  });

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
        child: child,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.indigo,
          backgroundColor: color,
          disabledBackgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
