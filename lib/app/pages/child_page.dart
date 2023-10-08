// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/bloc/child_side_bloc.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
import 'package:times_up_flutter/app/pages/set_child_page.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_empty_content.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';
import 'package:times_up_flutter/models/notification_model/notification_model.dart';
import 'package:times_up_flutter/services/app_usage_service.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({
    required this.appUsage,
    Key? key,
    this.database,
    this.child,
  }) : super(key: key);
  final Database? database;
  final ChildModel? child;
  final AppUsageService appUsage;

  static Widget create(
    BuildContext context,
    Database database,
    ChildModel child,
  ) {
    final appUsage = Provider.of<AppUsageService>(context, listen: false);

    return BlocProvider(
      create: (_) => ChildSideBloc(),
      child: FutureBuilder(
        future: appUsage.getAppUsageService(),
        builder: (_, snapshot) => ChildPage(
          database: database,
          child: child,
          appUsage: appUsage,
        ),
      ),
    );
  }

  @override
  _ChildPageState createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> with WidgetsBindingObserver {
  void sendLocalToBloCNotification(BuildContext context) {
    context.read<ChildSideBloc>().add(GetNotifications());
    Navigator.pop(context);
  }

  void sendLocalToBloCAppList(BuildContext context) {
    context.read<ChildSideBloc>().add(GetAppList());
    Navigator.pop(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Timer.periodic(const Duration(minutes: 5), (timer) {
      widget.database
          ?.liveUpdateChild(widget.child!, timer.tick, widget.appUsage);
    });
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: Colors.indigo,
      color: Colors.white,
      onRefresh: () => _refresh(widget.child, context, widget.database!),
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.child != null)
                Container(
                  height: 300,
                  color: Colors.indigo,
                  child: DrawerHeader(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.child!.image!),
                            radius: 45,
                          ),
                          const SizedBox(height: 6),
                          JHDisplayText(
                            text: '${widget.child!.name} ',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              JHDisplayText(
                                text: '${widget.child!.email} ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          JHDisplayText(
                            text: '${widget.child!.id} ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 7),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(),
              const Divider(
                height: 0.5,
                thickness: 0.2,
                color: Colors.grey,
              ),
              const SizedBox(height: 5 * 2),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification'),
                onTap: () => sendLocalToBloCNotification(context),
              ),
              const Divider(
                height: 0.5,
                thickness: 0.2,
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.settings_applications),
                title: const Text('App usage'),
                onTap: () => sendLocalToBloCAppList(context),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<SetChildPage>(
                    builder: (context) => const SetChildPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.indigo,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          title: const JHDisplayText(
            text: 'Child',
            style: TextStyle(color: Colors.indigo),
          ),
          iconTheme: const IconThemeData(color: Colors.indigo),
          centerTitle: true,
        ),
        //ignore: non_null
        body: widget.appUsage.info.isEmpty
            ? const JHEmptyContent(
                title: 'This is the child page',
                message: 'Nothing to show at the moment',
              )
            : Center(
                child: BlocConsumer<ChildSideBloc, ChildSideState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ChildSideInitial) {
                      return _buildInitialInput(context);
                    } else if (state is ChildSideFetching) {
                      return _buildLoading();
                    } else if (state is ChildSideNotification) {
                      return _buildNotification();
                    } else if (state is ChildSideAppList) {
                      return _buildAppList(widget.appUsage);
                    } else {
                      return _buildInitialInput(context);
                    }
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildInitialInput(BuildContext context) {
    return const Center(
      child: JHDisplayText(
        text: 'Child Page',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
      ),
    );
  }

  Widget _buildNotification() {
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
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: JHDisplayText(
                      text: data[index].title ?? 'No title available',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    trailing: JHDisplayText(
                      text: data[index].message ?? 'No message available',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasData) {
          return ErrorWidget(snapshot.error!);
        }
        return const JHEmptyContent(
          message:
              'This side of the app will display the list of Notifications',
          title: 'Notification page',
          fontSizeMessage: 13,
          fontSizeTitle: 23,
        );
      },
    );
  }

  Widget _buildAppList(AppUsageService appUsage) {
    return ListView.builder(
      itemCount: appUsage.info.length,
      itemBuilder: (context, index) {
        return ListTile(
          horizontalTitleGap: 30,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          leading: Image.memory(
            appUsage.info[index].appIcon!,
            height: 50,
          ),
          title: JHDisplayText(
            text: appUsage.info[index].appName,
            style: const TextStyle(fontSize: 15),
          ),
          trailing: JHDisplayText(
            text: appUsage.info[index].usage.toString().t(),
            style: const TextStyle(fontSize: 14, color: Colors.indigo),
          ),
        );
      },
    );
  }

  Future<void> _refresh(
    ChildModel? model,
    BuildContext context,
    Database database,
  ) async {
    final geo = Provider.of<GeoLocatorService>(context, listen: false);
    final apps = Provider.of<AppUsageService>(context, listen: false);
    final position = await geo.getInitialLocation();
    final battery = await Battery().batteryLevel;

    await database.getUserCurrentChild(
      model?.id ?? '',
      apps,
      GeoPoint(position.latitude, position.longitude),
      battery: battery.toString(),
    );
  }
}
