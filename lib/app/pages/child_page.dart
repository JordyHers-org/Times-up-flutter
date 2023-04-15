import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_control/app/bloc/child_side_bloc.dart';
import 'package:parental_control/app/pages/set_child_page.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/models/notification_model.dart';
import 'package:parental_control/services/app_usage_service.dart';
import 'package:parental_control/services/database.dart';
import 'package:provider/provider.dart';

class ChildPage extends StatefulWidget {
  final Database? database;
  final ChildModel? child;

  const ChildPage({Key? key, this.database, this.child}) : super(key: key);

  static Widget create(BuildContext context, database, ChildModel child) {
    final appUsage = Provider.of<AppUsageService>(context, listen: false);

    return BlocProvider(
      create: (_) => ChildSideBloc(),
      child: FutureBuilder(
          future: appUsage.getAppUsageService(),
          builder: (_, AsyncSnapshot snapshot) =>
              ChildPage(database: database, child: child)),
    );
  }

  @override
  _ChildPageState createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  ///Methods To send to Bloc => Local User
  void sendLocalToBloCNotification(BuildContext context) {
    var childSideBloc = context.read<ChildSideBloc>();
    childSideBloc.add(GetNotifications());
    Navigator.pop(context);
  }

  ///Methods To send to Bloc => Local User
  void sendLocalToBloCAppList(BuildContext context) {
    var childSideBloc = context.read<ChildSideBloc>();
    childSideBloc.add(GetAppList());
    Navigator.pop(context);
  }

  @override
  void initState() {
    /// This method updates the location on the map every 35 minutes
    Timer.periodic(const Duration(minutes: 35), (timer) {
      widget.database?.liveUpdateChild(widget.child!, timer.tick);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appUsage = Provider.of<AppUsageService>(context);
    return Scaffold(
        drawer: Drawer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            widget.child != null
                ? Container(
                    height: 250,
                    color: Colors.indigo,
                    child: DrawerHeader(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.child!.image!),
                            radius: 45,
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${widget.child!.name} ',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 12),
                          Text(
                            '${widget.child!.email} ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${widget.child!.id} ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 6),
                        ],
                      ),
                    )),
                  )
                : Container(),
            Divider(
              height: 0.5,
              thickness: 0.2,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () => sendLocalToBloCNotification(context),
            ),
            Divider(
              height: 0.5,
              thickness: 0.2,
              color: Colors.grey,
            ),
            ListTile(
                leading: Icon(Icons.settings_applications),
                title: Text('App usage'),
                onTap: () => sendLocalToBloCAppList(context)),
          ]),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SetChildPage()),
                  );
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.indigo,
                ))
          ],
          backgroundColor: Colors.white,
          title: Text(
            'Child',
            style: TextStyle(color: Colors.indigo),
          ),
          iconTheme: IconThemeData(color: Colors.indigo),
          centerTitle: true,
        ),
        body: appUsage.info == null
            ? EmptyContent(
                title: 'This is the child page',
                message: 'Nothing to show at the moment',
              )
            : Container(
                child: Center(
                  child: BlocConsumer<ChildSideBloc, ChildSideState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ChildSideInitial) {
                        return buildInitialInput(context);
                      } else if (state is ChildSideFetching) {
                        return buildLoading();
                      } else if (state is ChildSideNotification) {
                        return buildNotification();
                      } else if (state is ChildSideAppList) {
                        return buildAppList(appUsage);
                      } else {
                        return buildInitialInput(context);
                      }
                    },
                  ),
                ),
              ));
  }

  Widget buildInitialInput(BuildContext context) {
    return Center(
        child: Text('Child Page',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            )));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
      ),
    );
  }

  Widget buildNotification() {
    return StreamBuilder<List<NotificationModel>>(
        stream: widget.database!.notificationStream(childId: ''),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.indigo,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(data[index].title ?? 'No title available'),
                      trailing: Text(
                        data[index].message ?? 'No message available',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasData) {
            return ErrorWidget(snapshot.error!);
          }
          return EmptyContent(
            message:
                'This side of the app will display the list of Notifications',
            title: 'Notification page',
            fontSizeMessage: 13,
            fontSizeTitle: 23,
          );
        });
  }

  Widget buildAppList(appUsage) {
    return ListView.builder(
        itemCount: appUsage.info.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
                appUsage.info[index].appName,
                style: TextStyle(fontSize: 15),
              ),
              trailing: Text(parseResult(appUsage.info[index].usage.toString()),
                  style: TextStyle(fontSize: 14, color: Colors.indigo)));
        });
  }

  String parseResult(String value) {
    var removeColon = value.replaceAll(':', ' ');
    var result = removeColon.replaceAll('.', '');

    result = result.replaceRange(1, 1, ' day ');
    result = result.replaceRange(9, 9, ' hour ');
    result = result.replaceRange(18, null, ' minutes');

    if (result.contains('00 hour')) {
      result = result.replaceRange(0, 14, '');
      return result;
    } else if (result.contains('0 day')) {
      result = result.replaceRange(0, 5, '');
      return result;
    }
    return result;
  }
}
