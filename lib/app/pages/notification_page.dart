import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/models/notification_model/notification_model.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/notification_service.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:provider/provider.dart';

enum AppState { Loaded, Empty }

class NotificationPage extends StatefulWidget {
  final AuthBase auth;
  final NotificationService? notification;
  final Database? database;

  const NotificationPage({
    Key? key,
    required this.auth,
    this.notification,
    this.database,
  }) : super(key: key);

  static Widget create(
    BuildContext context,
    AuthBase auth,
  ) {
    final database = Provider.of<Database>(context, listen: false);
    final notification =
        Provider.of<NotificationService>(context, listen: false);
    return NotificationPage(
      auth: auth,
      notification: notification,
      database: database,
    );
  }

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  AppState appState = AppState.Empty;

  Future<void> _delete(BuildContext context, NotificationModel model) async {
    try {
      await widget.database?.deleteNotification(model.id!);
    } on FirebaseException catch (e) {
      await showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.auth.setToken();
    widget.notification?.configureFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStreamNotification(context);
  }

  Widget _buildStreamNotification(BuildContext context) {
    return StreamBuilder<List<NotificationModel>>(
      stream: widget.database?.notificationStream(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;

          return data!.isNotEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                      key: ValueKey<int>(index),
                      onDismissed: (DismissDirection direction) async {
                        debugPrint('DATA TO BE DELETED IS ${data[index].id}');
                        await _delete(context, data[index]);
                        setState(() {
                          debugPrint(' Notification deleted');
                          data.removeAt(index);
                          appState = AppState.Empty;
                          debugPrint(appState.toString());
                        });
                      },
                      direction: DismissDirection.endToStart,
                      child: Card(
                        color: CustomColors.indigoLight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              data[index].title ?? 'No title available',
                            ),
                            trailing: Text(
                              data[index].message ?? 'No message available',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : EmptyContent(
                  message: 'This side of the app will display the list of'
                      ' Notifications',
                  title: 'Notification page',
                  fontSizeMessage: 13,
                  fontSizeTitle: 23,
                );
        } else if (snapshot.hasData) {
          return ErrorWidget(snapshot.error!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
