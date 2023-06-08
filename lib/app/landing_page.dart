import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/pages/parent_page.dart';
import 'package:parental_control/app/pages/set_child_page.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late bool _isParent;
  late GeoLocatorService geoService;

  ///In order to pass this value auth declared in the [STATE]
  ///for Stateful classes to the actual LandingPage widget
  ///we need to use the key word [widget.auth]
  @override
  void initState() {
    setFlagParentOrChild();
    geoService = Provider.of<GeoLocatorService>(context, listen: false);
    super.initState();
  }

  ///Function to set sharedPreference On [Parent or Child] devices
  Future<void> setFlagParentOrChild() async {
    var isParent = await SharedPreference().getParentOrChild();
    setState(() {
      _isParent = isParent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      ///auth.authStateChanges is the stream  declared in the [auth.dart] class
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }

          /// Here we have added a provider [Database] as a parent of the Parent
          /// Page
          switch (_isParent) {
            /// THIS CASE SET THE APP AS A PARENT APP
            case true:
              return Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),

                ///Here the ShowCaseWidget triggers the Showcase view
                ///and passes the context
                child: FutureProvider(
                  initialData: null,
                  create: (context) => geoService.getInitialLocation(),
                  child: ShowCaseWidget(
                    builder: Builder(
                      builder: (context) => ParentPage.create(context, auth),
                    ),
                    autoPlay: false,

                    //autoPlayDelay: Duration(seconds: 3),
                    // autoPlayLockEnable: true,
                  ),
                ),
              );
            case false:

              /// THIS CASE SET THE APP AS A PARENT APP
              return Provider<AuthBase>(
                create: (_) => Auth(),
                child: Provider<Database>(
                  create: (_) => FirestoreDatabase(auth: auth, uid: user.uid),
                  child: FutureProvider(
                    initialData: geoService.getCurrentLocation,
                    create: (context) => geoService.getInitialLocation(),
                    child: SetChildPage.create(context),
                  ),
                ),
              );
            default:
              return CircularProgressIndicator();
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
