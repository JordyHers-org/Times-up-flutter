import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    required this.title,
    required this.subtitle,
    Key? key,
    this.trailing = const SizedBox.shrink(),
  }) : super(key: key);
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: JHDisplayText(
        text: title,
        fontSize: 17,
        style:
            const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
      ),
      subtitle: JHDisplayText(
        text: subtitle,
        style: TextStyle(color: Colors.grey.shade400),
      ),
      trailing: trailing,
    );
  }
}
