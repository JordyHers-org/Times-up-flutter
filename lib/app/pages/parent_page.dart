import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parental_control/app/config/geo_full.dart';
import 'package:parental_control/app/pages/child_details_page.dart';
import 'package:parental_control/app/pages/edit_child_page.dart';
import 'package:parental_control/app/pages/notification_page.dart';
import 'package:parental_control/app/pages/setting_page.dart';
import 'package:parental_control/common_widgets/child_horizontal_view.dart';
import 'package:parental_control/common_widgets/jh_display_text.dart';
import 'package:parental_control/common_widgets/jh_empty_content.dart';
import 'package:parental_control/common_widgets/jh_feature_widget.dart';
import 'package:parental_control/common_widgets/jh_header.dart';
import 'package:parental_control/common_widgets/jh_header_widget.dart';
import 'package:parental_control/common_widgets/jh_info_row_widget.dart';
import 'package:parental_control/common_widgets/jh_loading_widget.dart';
import 'package:parental_control/common_widgets/jh_summary_tile.dart';
import 'package:parental_control/common_widgets/show_logger.dart';
import 'package:parental_control/models/child_model/child_model.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/services/notification_service.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:parental_control/utils/data.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({
    Key? key,
    required this.auth,
    required this.geo,
    required this.database,
  }) : super(key: key);

  final AuthBase auth;
  final GeoLocatorService geo;
  final Database database;

  static Widget create(BuildContext context, AuthBase auth) {
    final database = Provider.of<Database>(context, listen: false);
    final geo = Provider.of<GeoLocatorService>(context, listen: false);

    return ParentPage(
      auth: auth,
      database: database,
      geo: geo,
    );
  }

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  int currentIndex = 0;
  int fontSize = 30;

  late bool _isShowCaseActivated;

  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _childListKey = GlobalKey();
  final GlobalKey _addKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setShowCaseView();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startShowCase() {
    return ShowCaseWidget.of(context).startShowCase(
      [_settingsKey, _childListKey, _addKey],
    );
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      setState(() {
        fontSize = 17;
      });
    }
    if (_scrollController.offset == _scrollController.initialScrollOffset) {
      setState(() {
        fontSize = 30;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
    var children = <Widget>[
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
    return NestedScrollView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            flexibleSpace: !value
                ? JHHeader(
                    fontSize: fontSize.toDouble(),
                  ).hP16
                : SizedBox.shrink(),
            backgroundColor: Colors.white,
            expandedHeight: !value ? 120 : 100,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !value
                    ? SizedBox.shrink()
                    : JHDisplayText(
                        text: 'Welcome',
                        fontSize: fontSize.toDouble(),
                        style: TextStyle(
                          color: CustomColors.indigoDark,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: BorderSide.none),
                  onPressed: () => SettingsPage.show(context, auth),
                  child: Showcase(
                    key: _settingsKey,
                    textColor: Colors.indigo,
                    description: 'change the settings here',
                    showArrow: true,
                    child: CircleAvatar(
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
          description: 'Add a new child here ',
          child: FloatingActionButton(
            onPressed: () => EditChildPage.show(
              context,
              database: Provider.of<Database>(context, listen: false),
            ),
            child: const Icon(Icons.add),
            backgroundColor: CustomColors.indigoLight,
          ),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget(
                    title: 'My Children',
                    subtitle: 'Choose child to get more info - scroll right ',
                    trailing: IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () => _startShowCase(),
                    ),
                  ).p8,
                  _buildChildrenList(database),
                  HeaderWidget(
                    title: 'Get to see our child live app usage',
                    subtitle: 'Click on it to have the full report',
                  ).p8,
                  JHSummaryTile(
                    title: 'Today, April 6 ',
                    time: '1 hr 5 min',
                    progressValue: 0.15,
                  ),
                  HeaderWidget(
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
                  JHFeatureWidget(
                    child: Png.google,
                    icon: Icons.timelapse_sharp,
                  ),
                  JHFeatureWidget(
                    child: Png.facebook,
                    icon: Icons.timelapse_sharp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenList(Database database) {
    return Showcase(
      textColor: Colors.indigo,
      description: 'Tap on the child to display info',
      key: _childListKey,
      child: Container(
        height: 165.0,
        child: StreamBuilder<List<ChildModel?>>(
          stream: database.childrenStream(),
          builder: (context, AsyncSnapshot snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData) {
              if (data != null && data.isNotEmpty) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Kids(
                      image_location: data[index]?.image,
                      image_caption: data[index]?.name,
                      onPressed: () =>
                          ChildDetailsPage.show(context, data[index]!),
                    );
                  },
                );
              } else {
                return JHEmptyContent(
                  child: Icon(Icons.info_outline_rounded),
                );
              }
            } else if (snapshot.hasError) {
              JHLogger.$.e(snapshot.error);
              return JHEmptyContent(
                title: 'Something went wrong ',
                message: 'Can\'t load items right now',
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Kids(
                  image_location: null,
                  image_caption: null,
                  onPressed: null,
                );
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
              )
            : LoadingWidget();
      },
    );
  }

  Future<void> _setShowCaseView() async {
    var isVisited = await SharedPreference().getDisplayShowCase();
    setState(() {
      _isShowCaseActivated = isVisited;
      SharedPreference().setDisplayShowCase();
    });

    _isShowCaseActivated == false
        ? WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context)
                .startShowCase([_settingsKey, _childListKey, _addKey]),
          )
        : null;
  }

  void _setIndex(int value) {
    setState(() {
      currentIndex = BottomNavigationData.items.keys.toList()[value];
    });
  }
}
