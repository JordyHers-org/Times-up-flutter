// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:times_up_flutter/theme/theme.dart';

class AnimatedGreenDot extends StatefulWidget {
  const AnimatedGreenDot({Key? key}) : super(key: key);

  @override
  _AnimatedGreenDotState createState() => _AnimatedGreenDotState();
}

class _AnimatedGreenDotState extends State<AnimatedGreenDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _colorAnimation = ColorTween(
      begin: Colors.green.shade500,
      end: Colors.green.shade900,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          alignment: Alignment.center,
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.greenPrimary,
            boxShadow: <BoxShadow>[
              BoxShadow(
                spreadRadius: 5,
                color: _colorAnimation.value!,
              ),
            ],
          ),
        );
      },
    );
  }
}
