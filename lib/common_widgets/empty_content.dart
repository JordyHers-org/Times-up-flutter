import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key? key,
    this.title = 'Nothing here ',
    this.fontSizeMessage = 18.0,
    this.fontSizeTitle = 32.0,
    this.message = ' Add a new item to get started',
  }) : super(key: key);

  final String title;
  final double fontSizeTitle;
  final double fontSizeMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSizeTitle,
              color: Colors.black54,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: fontSizeMessage,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
