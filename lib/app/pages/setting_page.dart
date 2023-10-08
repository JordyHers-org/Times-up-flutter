// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_any_logo/flutter_logo.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/show_alert_dialog.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/theme/theme_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.auth,
    required this.themeNotifier,
    Key? key,
    this.title,
    this.name,
    this.email,
    this.context,
  }) : super(key: key);
  final BuildContext? context;
  final ThemeNotifier themeNotifier;
  final AuthBase auth;
  final String? title;
  final String? name;
  final String? email;

  static Future<void> show(BuildContext context, AuthBase auth) async {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);

    await Navigator.of(context).push(
      MaterialPageRoute<SettingsPage>(
        builder: (context) => SettingsPage(
          context: context,
          auth: auth,
          themeNotifier: themeProvider,
        ),
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
        physics: const BouncingScrollPhysics(),
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
            onPressed: themeNotifier.toggleTheme,
            text: themeNotifier.isDarkMode ? 'Dark mode' : 'Light mode',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () {},
            text: 'Contact us',
          ),
          Image.asset('images/png/profile.png'),
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () => confirmSignOut(context, auth),
                      icon: const Icon(
                        Icons.logout,
                        size: 23,
                      ),
                    ),
                  ],
                ),
                buildItems(context),
                ListTile(
                  trailing: AnyLogo.tech.jordyHers.image(height: 25),
                  title: const JHDisplayText(
                    text: 'Copyright© Jordyhers',
                    style: TextStyle(color: Colors.indigo, fontSize: 12),
                  ),
                ),
              ],
            ),
          ).vP36,
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    required this.onPressed,
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);
  final IconData? icon;
  final String? text;
  final bool hasNavigation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(width: 15),
            JHDisplayText(
              text: text ?? '',
              style: TextStyles.body,
            ),
            const Spacer(),
            if (hasNavigation)
              const Icon(
                Icons.chevron_right,
                size: 25,
              ),
          ],
        ),
      ),
    );
  }
}
