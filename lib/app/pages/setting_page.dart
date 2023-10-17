// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_no_implementation.dart';
import 'package:times_up_flutter/common_widgets/show_alert_dialog.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';
import 'package:times_up_flutter/services/app_info_service.dart';
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
    this.appInfoService,
  }) : super(key: key);
  final BuildContext? context;
  final ThemeNotifier themeNotifier;
  final AuthBase auth;
  final String? title;
  final String? name;
  final String? email;
  final AppInfoService? appInfoService;

  static Future<void> show(BuildContext context, AuthBase auth) async {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    final appInfo = Provider.of<AppInfoService>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute<SettingsPage>(
        builder: (context) => SettingsPage(
          context: context,
          auth: auth,
          themeNotifier: themeProvider,
          appInfoService: appInfo,
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
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Update profile',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.language,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Change language',
          ),
          ProfileListItem(
            onPressed: () {},
            icon: themeNotifier.isDarkMode
                ? LineAwesomeIcons.moon
                : LineAwesomeIcons.sun,
            hasNavigation: false,
            text: themeNotifier.isDarkMode ? 'Dark mode' : 'Light mode',
            child: Switch(
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.greenAccent,
              inactiveTrackColor: Colors.red,
              onChanged: (_) => themeNotifier.toggleTheme(),
              value: themeNotifier.isDarkMode || false,
            ),
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
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
                const Center(
                  child: JHDisplayText(
                    text: 'Copyright© JordyHers-org',
                    fontSize: 8,
                    maxFontSize: 12,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Center(
                  child: JHDisplayText(
                    text: 'v${appInfoService?.appInfo.version ?? ''}',
                    fontSize: 8,
                    maxFontSize: 12,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ).vP16.vP16,
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
    this.child,
    this.hasNavigation = true,
  }) : super(key: key);
  final IconData? icon;
  final String? text;
  final bool hasNavigation;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
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
            if (child != null) child!,
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
