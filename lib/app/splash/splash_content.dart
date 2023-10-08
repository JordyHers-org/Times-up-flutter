// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({
    required this.text,
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String text;
  final String title;
  final IconData icon;
  @override
  _SplashContentState createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 30,
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  widget.icon,
                  size: 230,
                ),
              ),
              const SizedBox(height: 20),
              _SlideText(
                slideAnimation: _slideAnimation,
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(top: 160),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: JHDisplayText(
                    text: widget.title,
                    fontSize: 30,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : CustomColors.indigoLight,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _SlideText(
                slideAnimation: _slideAnimation,
                delay: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.only(top: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: JHDisplayText(
                    text: widget.text,
                    fontSize: 17,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? CustomColors.indigoLight
                          : Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SlideText extends StatelessWidget {
  const _SlideText({
    Key? key,
    this.child,
    this.slideAnimation,
    this.delay,
  }) : super(key: key);
  final Widget? child;
  final Animation<Offset>? slideAnimation;
  final Duration? delay;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: SlideTransition(
        position: slideAnimation!,
        child: _DelayedDisplay(
          delay: delay!,
          child: Transform.translate(
            offset: const Offset(0, 90),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _DelayedDisplay extends StatefulWidget {
  const _DelayedDisplay({
    required this.child,
    required this.delay,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final Duration delay;

  @override
  _DelayedDisplayState createState() => _DelayedDisplayState();
}

class _DelayedDisplayState extends State<_DelayedDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Visibility(
            visible: _animation.value != 0,
            child: child!,
          );
        },
        child: widget.child,
      ),
    );
  }
}
