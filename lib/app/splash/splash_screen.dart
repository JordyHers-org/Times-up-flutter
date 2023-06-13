import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/landing_page.dart';
import 'package:parental_control/app/splash/splash_content.dart';
import 'package:parental_control/common_widgets/custom_button.dart';
import 'package:parental_control/common_widgets/size_config.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:parental_control/utils/data.dart';

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
                itemCount: TabData.items.length,
                itemBuilder: (context, index) => SplashContent(
                  text: TabData.items[index]['text'],
                  title: TabData.items[index]['title'],
                  icon: TabData.items[index]['icon'],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomButton(
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
                  const SizedBox(height: 8),
                  CustomButton(
                    color: CustomColors.greenPrimary,
                    title: 'Child device'.toUpperCase(),
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
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      TabData.items.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(),
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
      margin: const EdgeInsets.only(right: 5),
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
