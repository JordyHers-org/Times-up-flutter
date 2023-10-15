import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:times_up_flutter/common_widgets/jh_custom_raised_button.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHNoImplementationWidget extends StatelessWidget {
  const JHNoImplementationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        height: 260,
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(LineAwesomeIcons.info),
              const JHDisplayText(
                text: 'Oops :( ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              const JHDisplayText(
                text: 'Not implemented yet. We are actively working to'
                    ' implement '
                    ' that we will let you know soon.',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ).vP16,
              const Spacer(),
              JHCustomRaisedButton(
                width: double.maxFinite,
                onPressed: () => Navigator.of(context).pop(),
                color: CustomColors.indigoDark,
                child: const JHDisplayText(
                  text: 'Ok',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ).p(20),
        ),
      ),
    );
  }
}
