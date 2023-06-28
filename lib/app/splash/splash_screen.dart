// ignore_for_file: library_private_types_in_public_api

import 'package:design_library/design_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:times_up_flutter/app/landing_page.dart';
import 'package:times_up_flutter/app/splash/splash_content.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';
import 'package:times_up_flutter/utils/data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.context}) : super(key: key);
  final BuildContext? context;

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
    JHSizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: TabData.items.length,
                itemBuilder: (context, index) => SplashContent(
                  text: TabData.items[index]['text'] as String,
                  title: TabData.items[index]['title'] as String,
                  icon: TabData.items[index]['icon'] as IconData,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  JHCustomButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: 'Parent device'.toUpperCase(),
                    onPress: () {
                      SharedPreference().setVisitingFlag();
                      SharedPreference().setParentDevice();
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute<LandingPage>(
                          builder: (context) => const LandingPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  JHCustomButton(
                    backgroundColor: CustomColors.greenPrimary,
                    title: 'Child device'.toUpperCase(),
                    onPress: () {
                      SharedPreference().setVisitingFlag();
                      SharedPreference().setChildDevice();
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute<LandingPage>(
                          builder: (context) => const LandingPage(),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
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
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
