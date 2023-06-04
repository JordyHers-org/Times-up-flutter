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

  List<Map<String, String>> splashData = [
    {
      'text': 'The perfect tool to control apps and monitor the time\n'
          'Your kids spend on screen. Easy to use ! \n'
          'Start by setting up your device then set up\n your kid\'s phone',
      'image': 'images/png/undraw_1.png'
    },
    {
      'text': 'Send notifications to your child when time  \n '
          ' limit is reached or when\n he has to go to bed. ',
      'image': 'images/png/undraw4.png'
    },
    {
      'text':
          "Because we care, Let's live track their location \nand see on the map where your child is.",
      'image': 'images/png/undraw3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: double.infinity,
          child: Column(
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
                    image: splashData[index]['image']!,
                    text: splashData[index]['text']!,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Spacer(flex: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                              onPressed: () {
                                SharedPreference().setVisitingFlag();
                                SharedPreference().setParentDevice();
                                print(
                                  'The page is set to Parent => now moving ......',
                                );
                                Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Parent device'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          ///-------------------------------------------------------------------
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  CustomColors.greenPrimary,
                                ),
                              ),
                              onPressed: () {
                                SharedPreference().setVisitingFlag();
                                SharedPreference().setChildDevice();

                                print(
                                  'The page is set to Child => now moving ......',
                                );
                                Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                );
                              },
                              child: Text(
                                ' Child device'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
              ),
            ],
          ),
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
