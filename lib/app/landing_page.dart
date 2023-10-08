import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:times_up_flutter/app/pages/parent_page.dart';
import 'package:times_up_flutter/app/pages/set_child_page.dart';
import 'package:times_up_flutter/common_widgets/jh_loading_widget.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';
import 'package:times_up_flutter/sign_in/sign_in_page.dart';

enum AppSide { parent, child }

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late AppSide _side;

  @override
  void initState() {
    _setFlagParentOrChild();
    super.initState();
  }

  Future<void> _setFlagParentOrChild() async {
    final isParent = await SharedPreference().getParentOrChild();
    setState(() {
      isParent ? _side = AppSide.parent : _side = AppSide.child;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final geoService = Provider.of<GeoLocatorService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          switch (_side) {
            case AppSide.parent:
              return _buildParentSide(user, geoService, auth);
            case AppSide.child:
              return _buildChildSide(auth, user, geoService, context);
          }
        }
        return const Scaffold(
          body: Center(
            child: LoadingWidget(),
          ),
        );
      },
    );
  }

  Provider<Database> _buildChildSide(
    AuthBase auth,
    User user,
    GeoLocatorService geoService,
    BuildContext context,
  ) {
    return Provider<Database>(
      create: (_) => FireStoreDatabase(auth: auth, uid: user.uid),
      child: FutureProvider(
        initialData: geoService.getCurrentLocation,
        create: (context) => geoService.getInitialLocation(),
        child: SetChildPage.create(context),
      ),
    );
  }

  Provider<Database> _buildParentSide(
    User user,
    GeoLocatorService geoService,
    AuthBase auth,
  ) {
    return Provider<Database>(
      create: (_) => FireStoreDatabase(
        auth: auth,
        uid: user.uid,
      ),
      child: FutureProvider(
        initialData: null,
        create: (context) => geoService.getInitialLocation(),
        child: ShowCaseWidget(
          builder: Builder(
            builder: (context) => ParentPage.create(context, auth),
          ),
        ),
      ),
    );
  }
}
