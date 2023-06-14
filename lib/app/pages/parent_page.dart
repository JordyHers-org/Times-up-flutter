import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:parental_control/app/config/geo_full.dart';
import 'package:parental_control/app/config/geo_location.dart';
import 'package:parental_control/app/pages/child_details_page.dart';
import 'package:parental_control/app/pages/edit_child_page.dart';
import 'package:parental_control/app/pages/notification_page.dart';
import 'package:parental_control/app/pages/setting_page.dart';
import 'package:parental_control/common_widgets/child_horizontal_view.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/common_widgets/feature_widget.dart';
import 'package:parental_control/common_widgets/loading_map.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/services/notification_service.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:parental_control/common_widgets/show_logger.dart';

enum MapScreenState { Full, Small }

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key, this.auth}) : super(key: key);

  final AuthBase? auth;
  static Widget create(BuildContext context, AuthBase auth) {
    return ParentPage(auth: auth);
  }

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  late Geo geo;

  ///  Variables
  late TabController _tabController;
  late bool _isShowCaseActivated;
  late GeoLocatorService geoService;
  MapScreenState mapScreenState = MapScreenState.Small;

  /// Here we declare the GlobalKeys to enable Showcase
  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _childListKey = GlobalKey();
  final GlobalKey _addKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    geoService = Provider.of<GeoLocatorService>(context, listen: false);
    _tabController = TabController(length: 2, vsync: this);
    _setShowCaseView();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  /// This function takes care of the ShowCase logic
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

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return mapScreenState == MapScreenState.Small
        ? Scaffold(
            body: _buildParentPageContent(context, auth, database),
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
              ),
            ),
          )
        : _buildMapFullScreen(database);
  }

  Widget _buildParentPageContent(
    BuildContext context,
    AuthBase auth,
    Database database,
  ) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: CustomColors.indigoDark,
            expandedHeight: MediaQuery.of(context).size.height * 0.12,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time's Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: CustomColors.indigoLight,
                    fontSize: 22,
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
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            pinned: true,
            floating: true,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.all(4.0),
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),

              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.white,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Dashboard',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Notifications',
                ),
              ],
            ),
          ),
        ];
      },
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// Tab bar view here
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                // first tab bar view widget
                CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ListTile(
                            title: Text(
                              'My Children',
                              style: TextStyle(color: Colors.indigo),
                            ),
                            subtitle: Text(
                              'Choose child to get more infos - scroll right ',
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                            trailing: Icon(
                              Icons.info_outline_rounded,
                              color: Colors.deepOrangeAccent.shade100,
                            ),
                          ).p8,
                          SizedBox(height: 3),
                          _buildChildrenList(database),
                          _header(),
                          Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.black.withOpacity(0.14),
                            ),
                            child: GestureDetector(
                              onLongPress: () => setState(() {
                                mapScreenState = MapScreenState.Full;
                              }),
                              child: Consumer<Position?>(
                                builder: (_, position, __) {
                                  return (position != null)
                                      ? Geo(position, database)
                                      : LoadingMap();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          FeatureWidget(
                            title: '-- 00 h:00 min --',
                            icon: Icons.access_alarm,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Provider<NotificationService>(
                  create: (_) => NotificationService(),
                  builder: (context, __) {
                    return NotificationPage.create(context, widget.auth!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildrenList(Database database) {
    return Showcase(
      textColor: Colors.indigo,
      description: 'Tap on the child to display infos',
      key: _childListKey,
      child: Container(
        decoration: CustomDecoration.withShadowDecoration,
        height: 160.0,
        child: StreamBuilder<List<ChildModel?>>(
          stream: database.childrenStream(),
          builder: (context, AsyncSnapshot snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData) {
              if (data != null && data.isNotEmpty) {
                return ListView.builder(
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
                return EmptyContent();
              }
            } else if (snapshot.hasError) {
              Logging.logger.e(snapshot.error);
              return EmptyContent(
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

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "Follow your child's location ",
            style: TextStyle(color: CustomColors.indigoLight),
          ),
        ),
        Text(
          'Long Press the map to open the full screen mode',
          style: TextStyle(color: CustomColors.greenPrimary),
        ),
      ],
    ).p16;
  }

  Widget _buildMapFullScreen(database) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            setState(() {
              mapScreenState = MapScreenState.Small;
            });
          },
        ),
      ),
      body: SafeArea(
        child: Consumer<Position>(
          builder: (_, position, __) {
            return GeoFull(position, database);
          },
        ),
      ),
    );
  }
}
