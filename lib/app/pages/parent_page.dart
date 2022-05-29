import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parental_control/app/pages/child_details_page.dart';
import 'package:parental_control/app/pages/edit_child_page.dart';
import 'package:parental_control/app/pages/notification_page.dart';
import 'package:parental_control/app/pages/setting_page.dart';
import 'package:parental_control/common_widgets/child_horizontal_view.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/services/notification_service.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../config/geo_full.dart';
import '../config/geo_location.dart';

enum MapScreenState { Full, Small }

class ParentPage extends StatefulWidget {
  final AuthBase auth;

  const ParentPage({Key key, @required this.auth}) : super(key: key);

  static Widget create(BuildContext context, AuthBase auth) {
    return ParentPage(auth: auth);
  }

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  Geo geo;

  ///  Variables
  TabController _tabController;
  bool _isShowCaseActivated;
  GeoLocatorService geoService;
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
  /// __________________________________________________________________________
  Future<void> _setShowCaseView() async {
    bool isVisited = await SharedPreference().getDisplayShowCase();
    setState(() {
      _isShowCaseActivated = isVisited;

      ///Set that the app has been visited
      SharedPreference().setDisplayShowCase();
    });

    _isShowCaseActivated == false
        ? WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)
            .startShowCase([_settingsKey, _childListKey, _addKey]))
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return mapScreenState == MapScreenState.Small
        ? Scaffold(
            body: _buildParentPageContent(context, auth),
            floatingActionButton: Showcase(
              key: _addKey,
              textColor: Colors.white,
              showcaseBackgroundColor: Colors.indigo,
              description: 'Add a new child here ',
              child: FloatingActionButton(
                onPressed: () => EditChildPage.show(context,
                    database: Provider.of<Database>(context, listen: false)),
                child: const Icon(Icons.add),
              ),
            ),
          )
        : _buildMapFullScreen(database);
  }

  Widget _buildParentPageContent(BuildContext context, AuthBase auth) {
    final database = Provider.of<Database>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Time's Up",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white38,
                          fontSize: 22),
                    ),
                    TextButton(
                      onPressed: () => SettingsPage.show(context, auth),
                      child: Showcase(
                        key: _settingsKey,
                        textColor: Colors.white,
                        showcaseBackgroundColor: Colors.indigo,
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
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Colors.white,
                    ),

                    labelColor: Colors.indigo,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Control',
                      ),

                      // second tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Notifications',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Tab bar view here
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // first tab bar view widget
              CustomScrollView(
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
                            'Choose child to get more infos ',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          trailing: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.deepOrangeAccent.shade100,
                          ),
                        ).p8,
                        Divider(
                            height: 5,
                            color: Colors.grey.withOpacity(0.1),
                            thickness: 3),
                        SizedBox(height: 3),
                        _buildChildrenList(database),
                        Divider(
                            height: 5,
                            color: Colors.grey.withOpacity(0.1),
                            thickness: 3),
                        _header(),
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              mapScreenState = MapScreenState.Full;
                            });
                          },
                          child: Consumer<Position>(builder: (_, position, __) {
                            return (position != null)
                                ? Geo(position, database)
                                : Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        color: Colors.black.withOpacity(0.14)),
                                  );
                          }),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.all(45.0),
                          child: EmptyContent(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Second tab bar view widget
              ///
              ///
              Provider<NotificationService>(
                create: (_) => NotificationService(),
                builder: (context, __) =>
                    NotificationPage.create(context, widget.auth),
              ),
              //TODO:Display different commands Focus mode Cards etc
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChildrenList(Database database) {
    return Showcase(
      showcaseBackgroundColor: Colors.indigo,
      textColor: Colors.white,
      description: 'Tap on the child to display infos',
      key: _childListKey,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white),
          //color: Colors.grey,
          height: 160.0,
          child: StreamBuilder<List<ChildModel>>(
            stream: database.childrenStream(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                if (data.isNotEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Kids(
                          image_location: data[index].image,
                          image_caption: data[index].name,
                          onPressed: () =>
                              ChildDetailsPage.show(context, data[index]));
                    },
                  );
                } else {
                  return EmptyContent();
                }
              } else if (snapshot.hasError) {
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
                      onPressed: () =>
                          print('DEBUG: Loading children images...'));
                },
              );
            },
          )),
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
            style: TextStyle(color: Colors.indigo),
          ),
        ),
        Text(
          'Long Press the map to open the full screen mode',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    ).p16;
  }

  Widget _buildMapFullScreen(database) {
    print('trying to build full screen');
    return Scaffold(
      body: Consumer<Position>(builder: (_, position, __) {
        return (position != null)
            ? GeoFull(position, database)
            : Center(child: CircularProgressIndicator());
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mapScreenState = MapScreenState.Small;
          });
        },
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
