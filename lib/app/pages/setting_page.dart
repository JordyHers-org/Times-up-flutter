import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:parental_control/common_widgets/jh_display_text.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/common_widgets/show_logger.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/theme/theme.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({
    Key? key,
    this.title,
    this.name,
    this.email,
    this.context,
    required this.auth,
  }) : super(key: key);
  final BuildContext? context;
  final AuthBase auth;
  final String? title;
  final String? name;
  final String? email;

  static Future<void> show(BuildContext context, AuthBase auth) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => SettingsPage(context: context, auth: auth),
      ),
    );
  }

  Future<void> _signOut(BuildContext context, AuthBase auth) async {
    try {
      await auth.signOut();
    } catch (e) {
      JHLogger.$.e(e.toString());
    }
  }

  Future<void> confirmSignOut(BuildContext context, AuthBase auth) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignOut == true) {
      await _signOut(context, auth);
      Navigator.of(context).pop();
    }
  }

  Widget buildItems(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ProfileListItem(
            icon: LineAwesomeIcons.history,
            onPressed: () {},
            text: 'Update profile',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.language,
            onPressed: () {},
            text: 'Change language',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.moon,
            onPressed: () {},
            text: 'Dark mode',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () {},
            text: 'Contact us',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.chevron_left,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () => confirmSignOut(context, auth),
                      icon: Icon(
                        Icons.logout,
                        size: 23,
                      ),
                    )
                  ],
                ),
                buildItems(context),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.contact_support_sharp),
                    onPressed: () {},
                  ),
                  title: JHDisplayText(
                    text: 'Copyright© JordyHers',
                    style:
                        TextStyle(color: CustomColors.indigoDark, fontSize: 12),
                  ),
                )
              ],
            ),
          ).vP36
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool hasNavigation;
  final Function onPressed;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 25,
            ),
            SizedBox(width: 15),
            JHDisplayText(
              text: text ?? '',
              style: TextStyles.body,
            ),
            Spacer(),
            if (hasNavigation)
              Icon(
                Icons.chevron_right,
                size: 25,
                color: CustomColors.indigoDark,
              ),
          ],
        ),
      ),
    );
  }
}
