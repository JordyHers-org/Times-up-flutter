import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.indigo),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade400),
      ),
    );
  }
}
