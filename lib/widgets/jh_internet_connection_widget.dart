import 'package:flutter/material.dart';

// ignore: must_be_immutable
class JHInternetConnectionWidget extends StatefulWidget {
  JHInternetConnectionWidget({required this.internetConnected, Key? key})
      : super(key: key);
  bool? internetConnected;

  @override
  State<JHInternetConnectionWidget> createState() =>
      _JHInternetConnectionWidgetState();
}

class _JHInternetConnectionWidgetState
    extends State<JHInternetConnectionWidget> {
  final Duration _duration = const Duration(milliseconds: 800);
  @override
  Widget build(BuildContext context) {
    if (widget.internetConnected != null && widget.internetConnected!) {
      return const SizedBox.shrink();
    }
    return AnimatedContainer(
      duration: _duration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.internetConnected == null
            ? Colors.green.withOpacity(0.85)
            : Colors.red.withOpacity(0.85),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: AnimatedSwitcher(
          duration: _duration,
          child: Text(
            widget.internetConnected == null
                ? 'Back Online'
                : 'No Internet Connection',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
