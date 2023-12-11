// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/features/parent_side/language/language_page.dart';
import 'package:times_up_flutter/services/app_info_service.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/theme/theme_notifier.dart';
import 'package:times_up_flutter/widgets/jh_custom_button.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';
import 'package:times_up_flutter/widgets/jh_no_implementation.dart';
import 'package:times_up_flutter/widgets/show_alert_dialog.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

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
          JHDisplayText(
            text: 'Profile',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : CustomColors.indigoDark,
              fontWeight: FontWeight.w700,
            ),
            fontSize: 27,
            maxFontSize: 34,
          ).hP16,
          ProfileListItem(
            icon: LineAwesomeIcons.history,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Update profile',
          ).vTopP(12),
          ProfileListItem(
            icon: LineAwesomeIcons.language,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => LanguagePage.create(context, auth),
              ),
            ),
            text: 'Change language',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.bell,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Notification ',
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
          JHDisplayText(
            text: 'Privacy',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : CustomColors.indigoDark,
              fontWeight: FontWeight.w700,
            ),
            fontSize: 27,
            maxFontSize: 34,
          ).hP16.vP16,
          ProfileListItem(
            icon: Icons.privacy_tip,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Privacy policy',
          ),
          ProfileListItem(
            icon: Icons.file_copy,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Impressum',
          ),
          ProfileListItem(
            icon: Icons.contact_page_outlined,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Terms and conditions',
            isUnderLine: TextDecoration.underline,
          ),
          JHDisplayText(
            text: 'Get us',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : CustomColors.indigoDark,
              fontWeight: FontWeight.w700,
            ),
            fontSize: 27,
            maxFontSize: 34,
          ).hP16.vP16,
          ProfileListItem(
            icon: Icons.rate_review,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Rate us',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.bug,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Report Bug',
          ),
          ProfileListItem(
            icon: Icons.contact_support_rounded,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Contact us',
          ),
          ProfileListItem(
            icon: Icons.recommend,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'Recommend App',
          ),
          ProfileListItem(
            icon: Icons.question_answer,
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (_) => const JHNoImplementationWidget(),
            ),
            text: 'FAQ',
          ),
          const Center(
            child: JHDisplayText(
              text: 'Copyright© JordyHers-org',
              fontSize: 8,
              maxFontSize: 12,
              style: TextStyle(color: Colors.grey),
            ),
          ).vTopP(25),
          Center(
            child: JHDisplayText(
              text: 'v${appInfoService?.appInfo.version ?? ''}',
              fontSize: 8,
              maxFontSize: 12,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close_outlined,
            size: 23,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : CustomColors.indigoDark,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildItems(context),
              JHCustomButton(
                title: 'Log out',
                backgroundColor: Colors.red,
                borderColor: Colors.red,
                size: const Size(270, 50),
                onPress: () async => confirmSignOut(context, auth),
              ),
            ],
          ).vP8,
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
    this.isUnderLine = TextDecoration.none,
    this.hasNavigation = true,
  }) : super(key: key);
  final IconData? icon;
  final String? text;
  final bool hasNavigation;
  final TextDecoration? isUnderLine;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
      onTap: onPressed,
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 10,
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
