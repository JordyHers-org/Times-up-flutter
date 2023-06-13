import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parental_control/app/config/geo_full.dart';
import 'package:parental_control/app/config/geo_location.dart';
import 'package:parental_control/app/pages/child_details_page.dart';
import 'package:parental_control/app/pages/edit_child_page.dart';
import 'package:parental_control/app/pages/setting_page.dart';
import 'package:parental_control/common_widgets/autosize_text.dart';
import 'package:parental_control/common_widgets/child_horizontal_view.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/common_widgets/loading_map.dart';
import 'package:parental_control/common_widgets/summary_tile.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/notification_service.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'notification_page.dart';

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
  int currentIndex = 0;

  Map<int, BottomNavigationBarItem> items = {
    0: BottomNavigationBarItem(
      label: 'Dashboard',
      icon: Icon(
        Icons.dashboard_customize_outlined,
      ),
    ),
    1: BottomNavigationBarItem(
      label: 'Notification',
      icon: Icon(
        Icons.notifications_on_outlined,
      ),
    ),
    2: BottomNavigationBarItem(
      label: 'Location',
      icon: Icon(
        Icons.location_history,
      ),
    )
  };

  late bool _isShowCaseActivated;

  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _childListKey = GlobalKey();
  final GlobalKey _addKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setShowCaseView();
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

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = items.keys.toList()[value];
          });
        },
        items: items.values.toList(),
      ),
      body: _buildParentPageContent(context, auth, database),
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
      _buildMapFullScreen(database),
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
      physics: BouncingScrollPhysics(),
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 90,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.menu_rounded,
                  color: CustomColors.indigoPrimary,
                  size: 25,
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
          ),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  DisplayText(
                    fontSize: 35,
                    text: 'Welcome',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w900,
                    ),
                  ).hP8,
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
                  _buildChildrenList(database),
                  _header(),
                  SummaryTile(),
                  // Row(
                  //   children: [
                  //     InfoBox(
                  //       icon: Icons.volume_up_outlined,
                  //       iconColor: CustomColors.indigoDark,
                  //       child: Container(
                  //         width: 100,
                  //         child: Text(
                  //           ' In this section you will be able to track what '
                  //           'your child is listening to.',
                  //           style: TextStyle(color: Colors.grey),
                  //         ),
                  //       ),
                  //     ),
                  //     InfoBox(
                  //       icon: Icons.lightbulb,
                  //       iconColor: CustomColors.indigoDark,
                  //       child: Text(' This is a live event'),
                  //     ),
                  //   ],
                  // ),
                  // FeatureWidget(
                  //   title: '🚀 10 h:00 min',
                  //   icon: Icons.timelapse_sharp,
                  // ),
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
      description: 'Tap on the child to display infos',
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
              debugPrint(snapshot.error.toString());
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
        DisplayText(
          text: 'Get to see our child live app usage',
          style: TextStyle(color: Colors.indigo),
        ),
        SizedBox(height: 2),
        DisplayText(
          text: 'Click on it to have the full report',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    ).p16;
  }

  Widget _buildMapFullScreen(Database database) {
    return Consumer<Position?>(
      builder: (_, position, __) {
        return position != null ? GeoFull(position, database) : LoadingMap();
      },
    );
  }
}
