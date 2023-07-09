import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_custom_raised_button.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/theme/theme.dart';

class FormSubmitButton extends JHCustomRaisedButton {
  FormSubmitButton({
    required String text,
    required VoidCallback onPressed,
    Key? key,
    Color? color,
  }) : super(
          key: key,
          child: JHDisplayText(
            text: text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          height: 44,
          color: color ?? CustomColors.indigoDark,
          borderRadius: 4,
          onPressed: onPressed,
        );
}
