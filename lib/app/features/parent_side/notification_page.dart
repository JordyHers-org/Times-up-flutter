// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
import 'package:times_up_flutter/models/notification_model/notification_model.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/notification_service.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';
import 'package:times_up_flutter/widgets/jh_loading_widget.dart';
import 'package:times_up_flutter/widgets/show_exeption_alert.dart';

enum AppState { loaded, empty }

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    required this.auth,
    Key? key,
    this.notification,
    this.database,
  }) : super(key: key);
  final AuthBase auth;
  final NotificationService? notification;
  final Database? database;

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
  AppState appState = AppState.empty;

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
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : CustomColors.indigoDark;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, value) {
        return [
          SliverAppBar(
            elevation: 0.5,
            shadowColor: CustomColors.indigoLight,
            iconTheme: const IconThemeData(color: Colors.red),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 50,
            pinned: true,
            floating: true,
          )
        ];
      },
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: JHDisplayText(
                text: 'Notifications',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
                fontSize: 32,
                maxFontSize: 34,
              ).hP16,
            ),
            SliverToBoxAdapter(
              child: JHDisplayText(
                text: 'slide from right to left to dismiss',
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
                fontSize: 12,
                maxFontSize: 14,
              ).hP16,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Container(child: _buildStreamNotification(context)),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamNotification(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : CustomColors.indigoDark;
    return StreamBuilder<List<NotificationModel>>(
      stream: widget.database?.notificationStream(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasData) {
          final data = snapshot.data;

          return data!.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: const Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      key: ValueKey<int>(index),
                      onDismissed: (DismissDirection direction) async {
                        await _delete(context, data[index]);
                        setState(() {
                          data.removeAt(index);
                          appState = AppState.empty;
                        });
                      },
                      direction: DismissDirection.endToStart,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        subtitle: JHDisplayText(
                          textAlign: TextAlign.start,
                          text: convertToFormattedString(
                            data[index].timeStamp.toString(),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        title: JHDisplayText(
                          text: data[index].title ?? 'No title available',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: color,
                            fontSize: 16,
                          ),
                        ),
                        trailing: JHDisplayText(
                          text: data[index].message ?? 'No message available',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: color,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JHDisplayText(
                      text: 'No notification ! ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(LineAwesomeIcons.info),
                  ],
                ).vTopP(100);
        } else if (snapshot.hasData) {
          return ErrorWidget(snapshot.error!);
        } else {
          return const Center(
            child: LoadingWidget(),
          ).vP16.vP16;
        }
      },
    );
  }
}
