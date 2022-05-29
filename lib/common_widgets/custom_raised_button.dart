import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {this.child,
      this.onPressed,
      this.borderRadius = 4.0,
      this.color,
      this.height = 55.0,
      this.width})
      : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
