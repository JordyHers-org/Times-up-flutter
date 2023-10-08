import 'package:flutter/material.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_header_widget.dart';
import 'package:times_up_flutter/theme/theme.dart';

class JHBottomSheet extends StatelessWidget {
  const JHBottomSheet({
    required this.message,
    required this.child,
    Key? key,
  }) : super(key: key);
  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView(
        physics: const ScrollPhysics(),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).p8,
              const HeaderWidget(
                title: 'Discover new tips',
                subtitle: 'Find out what you may not know yet',
              ).p8,
              SizedBox(
                height: 200,
                child: child,
              ).p16,
              JHDisplayText(
                text: message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: CustomColors.indigoLight,
                ),
              ).hP50,
            ],
          ),
        ],
      ),
    );
  }
}
