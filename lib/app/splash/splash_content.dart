import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/autosize_text.dart';
import 'package:parental_control/theme/theme.dart';

class SplashContent extends StatefulWidget {
  final String text, title;
  final IconData icon;

  const SplashContent({
    Key? key,
    required this.text,
    required this.title,
    required this.icon,
  }) : super(key: key);
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
      begin: Offset(0, 1),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    widget.icon,
                    size: 260,
                  ),
                ),
                SizedBox(height: 20),
                _SlideText(
                  slideAnimation: _slideAnimation,
                  delay: Duration(milliseconds: 200),
                  child: DisplayText(
                    text: widget.title,
                    fontSize: 25,
                    style: TextStyle(
                      color: CustomColors.indigoDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _SlideText(
                  slideAnimation: _slideAnimation,
                  delay: Duration(milliseconds: 300),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: DisplayText(
                      text: widget.text,
                      fontSize: 17,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
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
      ),
    );
  }
}

class _SlideText extends StatelessWidget {
  final Widget? child;
  final Animation<Offset>? slideAnimation;
  final Duration? delay;

  const _SlideText({
    Key? key,
    this.child,
    this.slideAnimation,
    this.delay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: SlideTransition(
        position: slideAnimation!,
        child: _DelayedDisplay(
          delay: delay!,
          child: Transform.translate(
            offset: Offset(0, 90),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _DelayedDisplay extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _DelayedDisplay({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

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
