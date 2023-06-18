import 'package:flutter/material.dart';

import 'jh_display_text.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: JHDisplayText(
        text: title,
        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
      subtitle: JHDisplayText(
        text: subtitle,
        style: TextStyle(color: Colors.grey.shade400),
      ),
      trailing: trailing,
    );
  }
}
