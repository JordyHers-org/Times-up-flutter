import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';

class JHEmptyContent extends StatelessWidget {
  const JHEmptyContent({
    Key? key,
    this.title = 'Nothing here ',
    this.fontSizeMessage = 18.0,
    this.fontSizeTitle = 32.0,
    this.child,
    this.message = ' Add a new item to get started',
  }) : super(key: key);

  final String? title;
  final Widget? child;
  final double fontSizeTitle;
  final double fontSizeMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (child != null)
            child!
          else
            JHDisplayText(
              text: title!,
              style: TextStyle(
                fontSize: fontSizeTitle,
                color: Colors.grey.shade400,
              ),
            ),
          JHDisplayText(
            text: message,
            style: TextStyle(
              fontSize: fontSizeMessage,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
