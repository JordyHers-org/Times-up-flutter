// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:times_up_flutter/app/features/parent_side/child_details_page.dart';
import 'package:times_up_flutter/app/features/parent_side/edit_child_page.dart';
import 'package:times_up_flutter/app/features/parent_side/map_page.dart';
import 'package:times_up_flutter/app/features/parent_side/notification_page.dart';
import 'package:times_up_flutter/app/features/parent_side/setting_page.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
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
import 'package:times_up_flutter/widgets/child_horizontal_view.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';
import 'package:times_up_flutter/widgets/jh_empty_content.dart';
import 'package:times_up_flutter/widgets/jh_header.dart';
import 'package:times_up_flutter/widgets/jh_header_widget.dart';
import 'package:times_up_flutter/widgets/jh_info_row_widget.dart';
import 'package:times_up_flutter/widgets/jh_shimmer_map.dart';
import 'package:times_up_flutter/widgets/jh_summary_tile.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

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
  late AnimationController _animationController;
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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
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
      create: (context) => NotificationService(),
      builder: (context, __) {
        return NotificationPage.create(context, auth);
      },
    );
  }

  Widget _buildDashboard(Database database, AuthBase auth) {
    final themeData = Theme.of(context);
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
                Showcase(
                  key: _settingsKey,
                  textColor: Colors.indigo,
                  description:
                      AppLocalizations.of(context).changeTheSettingsHere,
                  child: IconButton.outlined(
                    onPressed: () => SettingsPage.show(context, auth),
                    icon: const Icon(Icons.settings),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : CustomColors.indigoPrimary,
                  ),
                ),
              ],
            ),
            pinned: true,
            floating: true,
          ),
        ];
      },
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        color: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.indigo,
        onRefresh: () => Future.wait([
          _getAverageUsage(),
          _getAllChildLocations(),
          _loadingTime(),
        ]),
        child: Scaffold(
          floatingActionButton: Showcase(
            key: _addKey,
            textColor: Colors.indigo,
            description: AppLocalizations.of(context).addNewChildHere,
            child: FloatingActionButton(
              onPressed: () => EditChildPage.show(
                context,
                database: database,
              ),
              backgroundColor: CustomColors.greenPrimary,
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
                        subtitle: 'Choose child to get more info - scroll '
                            'right',
                        trailing: IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: _startShowCase,
                        ),
                      ).hP4,
                      _buildChildrenList(database),
                      const HeaderWidget(
                        title: 'Get to see our child live app usage',
                        subtitle: 'Click on it to have the full report',
                      ).hP4,
                      JHSummaryTile(
                        title: formatDateTime(DateTime.now()),
                        time: _averageUsage.toString().t(),
                        progressValue: calculatePercentage(_averageUsage),
                      ).vP4,
                      const HeaderWidget(
                        title: 'Information Section',
                        subtitle: 'Get tips on how to use the app.',
                      ).hP4,
                      JHInfoRow(
                        animationController: _animationController,
                        icon_1: Icons.auto_graph_outlined,
                        icon_2: Icons.message_outlined,
                        dataOne: MockData.text_1,
                        dataTwo: MockData.text_2,
                      ).p8,
                      JHInfoRow(
                        animationController: _animationController,
                        icon_1: Icons.lightbulb_rounded,
                        icon_2: Icons.volume_up_outlined,
                        dataOne: MockData.text_3,
                        dataTwo: MockData.text_4,
                      ).p8,
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChildrenList(Database database) {
    return Showcase(
      textColor: Colors.indigo,
      description: 'Tap on the child to display info',
      key: _childListKey,
      child: SizedBox(
        height: 155,
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
                    return ChildListView(
                      imageLocation: data[index]?.image,
                      imageCaption: data[index]?.name,
                      onPressed: () =>
                          ChildDetailsPage.show(context, data[index]!),
                    );
                  },
                );
              } else {
                return const JHEmptyContent(
                  fontSizeMessage: 10,
                  child: Icon(Icons.info_outline_rounded),
                );
              }
            } else if (snapshot.hasError) {
              JHLogger.$.e(snapshot.error);
              return const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JHDisplayText(
                      text: 'Something went wrong ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(LineAwesomeIcons.info_circle),
                  ],
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ChildListView();
              },
            );
          },
        ),
      ),
    ).hP4;
  }

  Widget _buildMapFullScreen(Database database, AuthBase auth) {
    return Consumer<Position?>(
      builder: (context, position, __) {
        return position != null
            ? MapView.create(
                context,
                position: position,
                database: database,
                auth: auth,
                locations: values,
              )
            : const ShimmerMap();
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

  Future<void> _loadingTime() async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }
}
