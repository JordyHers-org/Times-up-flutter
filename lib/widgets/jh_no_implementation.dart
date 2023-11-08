import 'package:flutter/material.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/widgets/jh_custom_raised_button.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';

class JHNoImplementationWidget extends StatelessWidget {
  const JHNoImplementationWidget({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);
  final String? title;
  final String? content;

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
              Row(
                children: [
                  const Spacer(),
                  JHDisplayText(
                    text: title ?? 'Oops  ',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.error),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
              JHDisplayText(
                text: content ?? 'Not implemented yet.',
                fontSize: 17,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : CustomColors.indigoDark,
                  fontWeight: FontWeight.w700,
                ),
              ).vP16,
              JHDisplayText(
                text: content ??
                    'We are actively working to'
                        ' implement '
                        ' that we will let you know soon.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : CustomColors.indigoDark,
                  fontWeight: FontWeight.w400,
                ),
              ).vP16,
              const Spacer(),
              JHCustomRaisedButton(
                width: double.maxFinite,
                onPressed: () => Navigator.of(context).pop(),
                color: CustomColors.indigoDark,
                child: const JHDisplayText(
                  text: 'OK',
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
