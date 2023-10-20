// ignore: lines_longer_than_80_chars
// ignore_for_file: library_private_types_in_public_api,use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:times_up_flutter/app/features/parent_side/app_list_page.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
import 'package:times_up_flutter/l10n/l10n.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';
import 'package:times_up_flutter/models/notification_model/notification_model.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/widgets/jh_battery_widget.dart';
import 'package:times_up_flutter/widgets/jh_custom_button.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';
import 'package:times_up_flutter/widgets/jh_empty_content.dart';
import 'package:times_up_flutter/widgets/jh_header_widget.dart';
import 'package:times_up_flutter/widgets/jh_line_chart.dart';
import 'package:times_up_flutter/widgets/show_alert_dialog.dart';
import 'package:times_up_flutter/widgets/show_bottom_sheet.dart';
import 'package:times_up_flutter/widgets/show_exeption_alert.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({
    required this.database,
    required this.childModel,
    Key? key,
  }) : super(key: key);

  final Database database;
  final ChildModel childModel;

  static Future<void> show(BuildContext context, ChildModel model) async {
    final database = Provider.of<Database>(context, listen: false);

    await Navigator.of(context).push(
      PageRouteBuilder<Widget>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ChildDetailsPage(database: database, childModel: model);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  _ChildDetailsPageState createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Future<void> _deleteUserPictureAndChild(
    BuildContext context,
    ChildModel model,
  ) async {
    try {
      await widget.database.deleteChild(model);
    } on FirebaseException catch (e) {
      await showExceptionAlertDialog(
        context,
        title: AppLocalizations.of(context).operationFailed,
        exception: e,
      );
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChildModel?>(
      stream: widget.database.childStream(childId: widget.childModel.id),
      builder: (context, snapshot) {
        final child = snapshot.data;

        return Scaffold(
          body: _buildContentTemporary(
            context,
            child,
          ),
        );
      },
    );
  }

  Widget _buildContentTemporary(
    BuildContext context,
    ChildModel? model,
  ) {
    final themeData = Theme.of(context);
    if (model != null) {
      return NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              actions: [
                if (model.image != null)
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showCustomBottomSheet(
                          context,
                          animationController: _animationController,
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeData.scaffoldBackgroundColor,
                            ),
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(),
                                JHCustomButton(
                                  title: ' Bed Time',
                                  backgroundColor: Colors.indigo,
                                  onPress: () async => _sendNotification(
                                    context,
                                    model,
                                    'Hey Go to bed Now',
                                  ),
                                ),
                                JHCustomButton(
                                  title: 'Homework Time',
                                  backgroundColor: CustomColors.indigoLight,
                                  onPress: () async => _sendNotification(
                                    context,
                                    model,
                                    'Homework Time',
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(model.image!),
                        ).p4,
                      ),
                    ],
                  )
                else
                  const SizedBox.shrink(),
              ],
              elevation: 0.5,
              shadowColor: CustomColors.indigoLight,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: CustomColors.indigoPrimary,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              iconTheme: const IconThemeData(color: Colors.red),
              backgroundColor: themeData.scaffoldBackgroundColor,
              expandedHeight: 50,
              pinned: true,
              floating: true,
            ),
          ];
        },
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  JHDisplayText(
                    text: model.name,
                    style: TextStyle(
                      color: themeData.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    fontSize: 32,
                    maxFontSize: 34,
                  ).hP16,
                  HeaderWidget(
                    title: AppLocalizations.of(context).enterThisCode,
                    subtitle: AppLocalizations.of(context)
                        .longPressToCopyOrDoubleTapToShare,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          Clipboard.setData(
                            ClipboardData(text: model.id),
                          ).then((value) {
                            final snackBar = SnackBar(
                              content:
                                  Text(AppLocalizations.of(context).copyText),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                        onDoubleTap: () async {
                          await Share.share(
                            '${AppLocalizations.of(context).enterThisCode}'
                            ' \n${model.id}',
                          );
                        },
                        child: JHDisplayText(
                          text: model.id,
                          fontSize: 30,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ).vTopP(4),
                      JHBatteryWidget(
                        level: double.parse(model.batteryLevel ?? '0.0') / 100,
                      ),
                    ],
                  ).hP16,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 205,
                        width: double.infinity,
                        child: JHLineChart(model: model),
                      ),
                    ],
                  ).vTopP(20),
                  _AppUsedList(model: model).vP16,
                  JHCustomButton(
                    title: 'Delete Child',
                    backgroundColor: Colors.red,
                    onPress: () async => _confirmDelete(
                      context,
                      widget.childModel,
                    ),
                  ).vTopP(70),
                ]),
              ),
            ],
          ),
        ),
      );
    } else {
      return const JHEmptyContent(
        title: 'Nothing Here',
        message: ' Here is the kids details page',
      );
    }
  }

  Future<void> _confirmDelete(BuildContext context, ChildModel model) async {
    final didConfirmDelete = await showAlertDialog(
      context,
      title: 'Delete child',
      content: 'Are you sure you want to delete this child?',
      defaultActionText: 'Delete',
      cancelActionText: 'Cancel',
    );
    if (didConfirmDelete == true) {
      if (!mounted) return;
      await _deleteUserPictureAndChild(context, model);
      Navigator.of(context).pop();
    }
    return;
  }

  Future<void> _sendNotification(
    BuildContext context,
    ChildModel model,
    String content,
  ) async {
    try {
      await widget.database.setNotification(
        NotificationModel(
          id: model.id,
          title: ' Hey ${model.name}',
          body: 'Here is a new message',
          message: content,
          timeStamp: DateTime.now(),
        ),
        model,
      );
      Navigator.of(context).pop();
      if (!mounted) return;
      await showAlertDialog(
        context,
        title: 'Successful',
        content: 'Notification sent to ${model.name}',
        defaultActionText: 'OK',
      );
      JHLogger.$.d('Notification sent to device');
    } on FirebaseException catch (e) {
      await showExceptionAlertDialog(
        context,
        title: 'An error occurred',
        exception: e,
      );
    }
  }
}

class _AppUsedList extends StatelessWidget {
  const _AppUsedList({
    required this.model,
    Key? key,
  }) : super(key: key);
  final ChildModel model;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        if (model.appsUsageModel.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 300,
                child: HeaderWidget(
                  title: 'Summary of used apps',
                  subtitle: 'Click for more details',
                ),
              ),
              TextButton(
                child: Text(
                  'See all',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: CustomColors.indigoLight,
                    fontSize: 13,
                  ),
                ),
                onPressed: () => AppListPage.show(context, model),
              ),
            ],
          )
        else
          const SizedBox.shrink().vP16,
        if (model.appsUsageModel.isNotEmpty)
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (model.appsUsageModel.length * 0.20).toInt(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: model.appsUsageModel[index].appIcon != null
                        ? Image.memory(
                            model.appsUsageModel[index].appIcon!,
                            height: 35,
                          )
                        : const Icon(Icons.android),
                    title: Text(
                      model.appsUsageModel[index].appName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: themeData.dividerColor,
                      ),
                    ),
                    trailing: Text(
                      model.appsUsageModel[index].usage.toString().t(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: themeData.dividerColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        else
          const JHEmptyContent(
            message: 'Seems like you have not set up the child device \n',
            title: 'Set up the child device',
            fontSizeMessage: 8,
            fontSizeTitle: 12,
          ),
      ],
    );
  }
}
