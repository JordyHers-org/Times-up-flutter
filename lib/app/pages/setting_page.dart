import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:parental_control/common_widgets/show_logger.dart';

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
      Logging.logger.e(e.toString());

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
            onPressed: () {
              //TODO: ADD EASY LOCALIZATION TO SET UP LIVE TRANSLATION
            },
            text: 'Change language',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.moon,
            onPressed: () {},
            text: 'Dark mode',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () {
              //TODO: ADD CONTACT US PAGE
            },
            text: 'Contact us',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: () => confirmSignOut(context, auth),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                buildItems(context),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.contact_support_sharp),
                    onPressed: () {},
                  ),
                  trailing: Text(
                    'Developed by Jordy-Hershel',
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                )
              ],
            ),
          )
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              text ?? '',
              style: TextStyles.body,
            ),
            Spacer(),
            if (hasNavigation)
              Icon(
                LineAwesomeIcons.alternate_arrow_circle_right,
                size: 25,
                color: CustomColors.greenPrimary,
              ),
          ],
        ),
      ),
    );
  }
}
