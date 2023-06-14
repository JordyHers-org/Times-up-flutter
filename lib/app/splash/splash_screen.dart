import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/landing_page.dart';
import 'package:parental_control/app/splash/splash_content.dart';
import 'package:parental_control/common_widgets/size_config.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  final BuildContext? context;

  const SplashScreen({Key? key, this.context}) : super(key: key);

  static Widget create(BuildContext context) {
    return SplashScreen(context: context);
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  List<Map<String, dynamic>> splashData = [
    {
      'text':
          "Time's Up is your solution to monitor the time your kids spend on "
              'screen.',
      'title': 'Get your new companion',
      'icon': Icons.family_restroom,
    },
    {
      'text': 'The perfect tool to control apps and monitor the time '
          'Your kids spend on screen.',
      'title': 'Get insightful dashboard',
      'icon': Icons.dashboard_customize_outlined,
    },
    {
      'text': 'Send notifications to your child when time '
          ' limit is reached or when he has to go to bed.',
      'title': 'Control and Monitor',
      'icon': Icons.lock_reset,
    },
    {
      'text': "Because we care, Let's live track their location and see on "
          'the map where your child is.',
      'title': 'Get to track their Location',
      'icon': Icons.location_history,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]['text']!,
                  title: splashData[index]['title']!,
                  icon: splashData[index]['icon']!,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SideButton(
                    color: Theme.of(context).primaryColor,
                    title: 'Parent device'.toUpperCase(),
                    onPress: () {
                      SharedPreference().setVisitingFlag();
                      SharedPreference().setParentDevice();
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => LandingPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  SideButton(
                    color: CustomColors.greenPrimary,
                    title: ' Child device'.toUpperCase(),
                    onPress: () {
                      SharedPreference().setVisitingFlag();
                      SharedPreference().setChildDevice();
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => LandingPage(),
                        ),
                      );
                    },
                  ),
                  Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).primaryColor
            : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SideButton extends StatelessWidget {
  final Color color;
  final Function() onPress;
  final String title;
  const SideButton({
    Key? key,
    required this.color,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(width: 1.5, color: Colors.transparent),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.95,
            SizeConfig.screenHeight! * 0.07,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(11),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
