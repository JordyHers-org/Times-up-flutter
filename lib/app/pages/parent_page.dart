// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:times_up_flutter/app/config/geo_full.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
import 'package:times_up_flutter/app/pages/child_details_page.dart';
import 'package:times_up_flutter/app/pages/edit_child_page.dart';
import 'package:times_up_flutter/app/pages/notification_page.dart';
import 'package:times_up_flutter/app/pages/setting_page.dart';
import 'package:times_up_flutter/common_widgets/child_horizontal_view.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_empty_content.dart';
import 'package:times_up_flutter/common_widgets/jh_header.dart';
import 'package:times_up_flutter/common_widgets/jh_header_widget.dart';
import 'package:times_up_flutter/common_widgets/jh_info_row_widget.dart';
import 'package:times_up_flutter/common_widgets/jh_loading_widget.dart';
import 'package:times_up_flutter/common_widgets/jh_summary_tile.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';
import 'package:times_up_flutter/l10n/l10n.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';
import 'package:times_up_flutter/services/api_path.dart';
import 'package:times_up_flutter/services/app_usage_service.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/services/notification_service.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/utils/data.dart';

typedef ValueList = List<Map<String, dynamic>>;

class ParentPage extends StatefulWidget {
  const ParentPage({
    required this.auth,
    required this.geo,
    required this.database,
    required this.appUsage,
    Key? key,
  }) : super(key: key);

  final AuthBase auth;
  final GeoLocatorService geo;
  final Database database;
  final AppUsageService? appUsage;

  static Widget create(BuildContext context, AuthBase auth) {
    final database = Provider.of<Database>(context, listen: false);
    final geo = Provider.of<GeoLocatorService>(context, listen: false);
    final appUsage = Provider.of<AppUsageService>(context, listen: false);

    return ParentPage(
      auth: auth,
      database: database,
      geo: geo,
      appUsage: appUsage,
    );
  }

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  Duration _averageUsage = const Duration(seconds: 1);
  late ScrollController _scrollController;
  late ValueList values = <Map<String, dynamic>>[];
  late bool _isShowCaseActivated;

  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _childListKey = GlobalKey();
  final GlobalKey _addKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getAverageUsage();
    _getAllChildLocations();
    _setShowCaseView();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: currentIndex,
        onTap: _setIndex,
        items: BottomNavigationData.items.values.toList(),
      ),
      body: _buildParentPageContent(context, widget.auth, widget.database),
    );
  }

  Widget _buildParentPageContent(
    BuildContext context,
    AuthBase auth,
    Database database,
  ) {
    final children = <Widget>[
      _buildDashboard(database, auth),
      _buildNotificationPage(auth),
      _buildMapFullScreen(database, auth),
    ];
    return children[currentIndex];
  }

  Widget _buildNotificationPage(AuthBase auth) {
    return Provider<NotificationService>(
      create: (_) => NotificationService(),
      builder: (context, __) {
        return NotificationPage.create(context, auth);
      },
    );
  }

  Widget _buildDashboard(Database database, AuthBase auth) {
    final themeData = Theme.of(context);
    return StreamBuilder<List<ChildModel?>>(
      stream: database.childrenStream(),
      builder: (context, AsyncSnapshot<List<ChildModel?>> snapshot) {
        final data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return const JHEmptyContent(
            title: 'Error Occurred !',
          );
        } else {
          return NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  elevation: 0.5,
                  shadowColor: CustomColors.indigoLight,
                  toolbarHeight: value ? 75 : 90,
                  flexibleSpace:
                      !value ? const JHHeader().hP16 : const SizedBox.shrink(),
                  backgroundColor: themeData.scaffoldBackgroundColor,
                  expandedHeight: !value ? 120 : 100,
                  shape: ContinuousRectangleBorder(
                    side: BorderSide(
                      color: !value
                          ? themeData.scaffoldBackgroundColor
                          : CustomColors.indigoDark.withOpacity(0.5),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!value)
                        const SizedBox.shrink()
                      else
                        JHDisplayText(
                          text: AppLocalizations.of(context).welcome,
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      GestureDetector(
                        onTap: () => SettingsPage.show(context, auth),
                        child: Showcase(
                          key: _settingsKey,
                          textColor: Colors.indigo,
                          description: AppLocalizations.of(context)
                              .changeTheSettingsHere,
                          child: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pinned: true,
                  floating: true,
                ),
              ];
            },
            body: Scaffold(
              floatingActionButton: Showcase(
                key: _addKey,
                textColor: Colors.indigo,
                description: AppLocalizations.of(context).addNewChildHere,
                child: FloatingActionButton(
                  onPressed: () => EditChildPage.show(
                    context,
                    database: Provider.of<Database>(context, listen: false),
                  ),
                  backgroundColor: CustomColors.indigoLight,
                  child: const Icon(Icons.add),
                ),
              ),
              body: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          HeaderWidget(
                            title: 'My Children',
                            subtitle:
                                'Choose child to get more info - scroll right ',
                            trailing: IconButton(
                              icon: const Icon(Icons.info_outline),
                              onPressed: _startShowCase,
                            ),
                          ).p8,
                          _buildChildrenList(database),
                          const HeaderWidget(
                            title: 'Get to see our child live app usage',
                            subtitle: 'Click on it to have the full report',
                          ).p8,
                          JHSummaryTile(
                            title: formatDateTime(DateTime.now()),
                            time: data != null && data.isNotEmpty
                                ? _averageUsage.toString().t()
                                : '0h 0m',
                            progressValue: data != null && data.isNotEmpty
                                ? calculatePercentage(_averageUsage)
                                : 0,
                          ),
                          const HeaderWidget(
                            title: 'Information Section',
                            subtitle: 'Get tips on how to use the app.',
                          ).p8,
                          JHInfoRow(
                            icon_1: Icons.auto_graph_outlined,
                            icon_2: Icons.message_outlined,
                            text_1: MockData.text_1,
                            text_2: MockData.text_2,
                          ).p4,
                          JHInfoRow(
                            icon_1: Icons.lightbulb_rounded,
                            icon_2: Icons.volume_up_outlined,
                            text_1: MockData.text_3,
                            text_2: MockData.text_4,
                          ).p4,
                          Image.asset(
                            'images/png/home_page.png',
                          ).p4,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChildrenList(Database database) {
    return Showcase(
      textColor: Colors.indigo,
      description: 'Tap on the child to display info',
      key: _childListKey,
      child: SizedBox(
        height: 165,
        child: StreamBuilder<List<ChildModel?>>(
          stream: database.childrenStream(),
          builder: (context, AsyncSnapshot<List<ChildModel?>> snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData) {
              if (data != null && data.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Kids(
                      imageLocation: data[index]?.image,
                      imageCaption: data[index]?.name,
                      onPressed: () =>
                          ChildDetailsPage.show(context, data[index]!),
                    );
                  },
                );
              } else {
                return const JHEmptyContent(
                  child: Icon(Icons.info_outline_rounded),
                );
              }
            } else if (snapshot.hasError) {
              JHLogger.$.e(snapshot.error);
              return const JHEmptyContent(
                title: 'Something went wrong ',
                message: "Can't load items right now",
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Kids();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMapFullScreen(Database database, AuthBase auth) {
    return Consumer<Position?>(
      builder: (context, position, __) {
        return position != null
            ? GeoFull.create(
                context,
                position: position,
                database: database,
                auth: auth,
                locations: values,
              )
            : const LoadingWidget();
      },
    );
  }

  Future<void> _setShowCaseView() async {
    final isVisited = await SharedPreference().getDisplayShowCase();
    setState(() {
      _isShowCaseActivated = isVisited;
      SharedPreference().setDisplayShowCase();
    });

    if (!_isShowCaseActivated) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context)
            .startShowCase([_settingsKey, _childListKey, _addKey]),
      );
    }
  }

  Future<void> _getAllChildLocations() async {
    await FirebaseFirestore.instance
        .collection(APIPath.children(widget.auth.currentUser!.uid))
        .get()
        .then((document) {
      if (document.docs.isNotEmpty) {
        for (final element in document.docs) {
          values.add(element.data());
        }
      }
    });
  }

  void _setIndex(int value) {
    setState(() {
      currentIndex = BottomNavigationData.items.keys.toList()[value];
    });
  }

  void _startShowCase() {
    return ShowCaseWidget.of(context).startShowCase(
      [_settingsKey, _childListKey, _addKey],
    );
  }

  Future<void> _getAverageUsage() async {
    _averageUsage =
        (await widget.appUsage?.getChildrenAppUsageAverage(widget.database))!;
  }
}
