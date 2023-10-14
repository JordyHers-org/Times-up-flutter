import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHNoImplementationWidget extends StatelessWidget {
  const JHNoImplementationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 160,
        width: 100,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            children: [
              const JHDisplayText(
                text: 'Oops :( ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const JHDisplayText(
                text: 'Not implemented yet. We are actively working to'
                    ' implement'
                    ' that we will let you know soon.',
                style: TextStyle(color: Colors.grey),
              ).vP16,
            ],
          ).p(20),
        ),
      ),
    );
  }
}
