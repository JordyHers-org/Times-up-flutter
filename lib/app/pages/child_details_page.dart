import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parental_control/app/helpers/parsing_extension.dart';
import 'package:parental_control/common_widgets/bar_chart.dart';
import 'package:parental_control/common_widgets/custom_raised_button.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/models/notification_model.dart';
import 'package:parental_control/services/database.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({required this.database, required this.childModel});

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
  Future<void> _delete(BuildContext context, ChildModel model) async {
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

  var isPushed = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChildModel?>(
      stream: widget.database.childStream(childId: widget.childModel.id),
      builder: (context, snapshot) {
        final child = snapshot.data;
        final childName = child?.name ?? '';
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text(childName),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _confirmDelete(context, widget.childModel),
              ),
            ],
          ),
          body: _buildContentTemporary(context, child),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.more_vert),
            onPressed: () {
              setState(() {
                isPushed = !isPushed;
              });
              debugPrint('more is pushed');
            },
          ),
        );
      },
    );
  }

  Widget _buildContentTemporary(BuildContext context, ChildModel? model) {
    if (model != null) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildProfile(model),
                Column(
                  children: [
                    Text(
                      'Enter this code on the child\'s device',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Long press to copy or double tap to share',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(
                          ClipboardData(text: model.id.toString()),
                        ).then((value) {
                          final snackBar = SnackBar(
                            content: const Text('Code Copied!'),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                SizedBox(height: 6),
              ],
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 2,
              width: double.infinity,
              child: Container(
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: RichText(
                text: TextSpan(
                  text: "Send notifications to your Child's device",
                  style: TextStyle(color: Colors.indigo, fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: RichText(
                text: TextSpan(
                  text: 'Push the button ',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75.0, 22, 75, 12),
                    child: CustomRaisedButton(
                      child: Text(
                        ' Bed Time',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      borderRadius: 12,
                      color: Colors.indigo,
                      height: 45,
                      onPressed: () async {
                        try {
                          await widget.database.setNotification(
                            NotificationModel(
                              id: model.id,
                              title: ' Hey ${model.name}',
                              body: 'Here is a new message',
                              message: 'Go to bed now ',
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
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75.0, 12, 75, 6),
                    child: CustomRaisedButton(
                      child: Text(
                        'Homework Time',
                        style: TextStyle(fontSize: 17),
                      ),
                      borderRadius: 12,
                      color: Colors.white,
                      height: 45,
                      onPressed: () async {
                        try {
                          await widget.database.setNotification(
                            NotificationModel(
                              id: model.id,
                              title: ' Hey ${model.name}',
                              body: 'Here is a new message',
                              message: 'Homework Time',
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
                      },
                    ),
                  ),
                ],
              ),
              height: 150,
            ),
            SizedBox(height: 58),
            isPushed == true
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.appsUsageModel.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                              leading: Icon(Icons.phone_android),
                              title: Text(
                                '${model.appsUsageModel[index]['appName']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                model.appsUsageModel[index]['usage']
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
                        ),
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
            SizedBox(height: 50)
          ],
        ),
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
      await _delete(context, model);
      Navigator.of(context).pop();
    }
    return;
  }
}
