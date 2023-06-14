import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parental_control/app/helpers/parsing_extension.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/common_widgets/jh_bar_chart.dart';
import 'package:parental_control/common_widgets/jh_custom_button.dart';
import 'package:parental_control/common_widgets/jh_header_widget.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/models/child_model/child_model.dart';
import 'package:parental_control/models/notification_model/notification_model.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({
    required this.database,
    required this.childModel,
  });

  final Database database;
  final ChildModel childModel;

  static Future<void> show(BuildContext context, ChildModel model) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) =>
            ChildDetailsPage(database: database, childModel: model),
      ),
    );
  }

  @override
  _ChildDetailsPageState createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  Future<void> _deleteUserPictureAndChild(
    BuildContext context,
    ChildModel model,
  ) async {
    try {
      await widget.database.deleteChild(model);
    } on FirebaseException catch (e) {
      await showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChildModel?>(
      stream: widget.database.childStream(childId: widget.childModel.id),
      builder: (context, snapshot) {
        final child = snapshot.data;
        return Scaffold(
          body: _buildContentTemporary(context, child),
        );
      },
    );
  }

  Widget _buildContentTemporary(BuildContext context, ChildModel? model) {
    if (model != null) {
      return NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: CustomColors.indigoPrimary,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              iconTheme: IconThemeData(color: Colors.red),
              backgroundColor: Colors.white,
              expandedHeight: 50,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              pinned: true,
              floating: true,
            )
          ];
        },
        body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                HeaderWidget(
                  title: 'Enter this code on the child\'s device',
                  subtitle: 'Long press to copy or double tap to share ',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildProfile(model),
                    GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(
                          ClipboardData(text: model.id.toString()),
                        ).then((value) {
                          final snackBar = SnackBar(
                            content: const Text('Code Copied!'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      onDoubleTap: () async {
                        await Share.share(
                          "Enter this code on child's device:\n${model.id}",
                        );
                      },
                      child: Text(
                        model.id,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ).hP16,
                  ],
                ).p16,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      height: 205,
                      width: double.infinity,
                      child: model.appsUsageModel.isNotEmpty
                          ? AppUsageChart(
                              isEmpty: false,
                              name: model.name,
                            )
                          : AppUsageChart(
                              isEmpty: true,
                              name: model.name,
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                ListTile(
                  title: Text(
                    'Send notifications to your Child\'s device',
                    style: TextStyle(color: Colors.indigo),
                  ),
                  subtitle: Text(
                    'Push the button ',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ).p8,
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: ' Bed Time',
                        backgroundColor: Colors.indigo,
                        onPress: () async => await _sendNotification(
                          context,
                          model,
                          'Hey Go to bed Now',
                        ),
                      ),
                      CustomButton(
                        title: 'Homework Time',
                        backgroundColor: CustomColors.indigoLight,
                        onPress: () async => await _sendNotification(
                          context,
                          model,
                          'Homework Time',
                        ),
                      ),
                      CustomButton(
                        title: 'Delete Child',
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.red,
                        textColor: Colors.red,
                        onPress: () async => _confirmDelete(
                          context,
                          widget.childModel,
                        ),
                      ),
                    ],
                  ),
                  height: 250,
                ),
                SizedBox(height: 58),
                model.appsUsageModel.isNotEmpty
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.appsUsageModel.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ListTile(
                                leading: Icon(Icons.phone_android),
                                title: Text(
                                  '${model.appsUsageModel[index].appName}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  model.appsUsageModel[index].usage
                                      .toString()
                                      .t(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.indigo,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      )
                    : EmptyContent(
                        message: 'Tap on more to display apps statistics \n'
                            '        Tap again to hide',
                        title: 'Show apps Statistics',
                        fontSizeMessage: 12,
                        fontSizeTitle: 23,
                      ),
              ]))
            ]),
      );
    } else {
      return EmptyContent(
        title: 'Nothing Here',
        message: ' Here is the kids details page',
      );
    }
  }

  Widget _buildProfile(ChildModel model) {
    return Container(
      width: 120,
      height: 140,
      padding: EdgeInsets.all(3),
      child: Container(
        alignment: Alignment.topLeft,
        child: model.image == null
            ? Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.black.withOpacity(0.10),
                ),
              )
            : Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.image!),
                  ),
                ),
              ),
      ),
    );
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
        ),
        model,
      );
      await showAlertDialog(
        context,
        title: 'Successful',
        content: 'Notification sent to ${model.name}',
        defaultActionText: 'OK',
      );
      debugPrint('Notification sent to device');
    } on FirebaseException catch (e) {
      await showExceptionAlertDialog(
        context,
        title: 'An error occurred',
        exception: e,
      );
    }
  }
}
