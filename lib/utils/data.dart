import 'package:flutter/material.dart';
import 'package:times_up_flutter/theme/theme.dart';

class TabData {
  static List<Map<String, dynamic>> items = [
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
      'title': 'Control and \nMonitor',
      'icon': Icons.lock_reset,
    },
    {
      'text': "Because we care, Let's live track their location and see on "
          'the map where your child is.',
      'title': 'Get to track their Location',
      'icon': Icons.location_history,
    },
  ];
}

class BottomNavigationData {
  static Map<int, BottomNavigationBarItem> items = {
    0: const BottomNavigationBarItem(
      label: 'Dashboard',
      icon: Icon(
        Icons.dashboard_customize_outlined,
      ),
    ),
    1: const BottomNavigationBarItem(
      label: 'Notification',
      icon: Icon(
        Icons.notifications_on_outlined,
      ),
    ),
    2: const BottomNavigationBarItem(
      label: 'Location',
      icon: Icon(
        Icons.location_history,
      ),
    ),
  };
}

class MockData {
  static String text_1 = 'Get to know how to read and interpret the graphs '
      'that is a summary of how your child uses his device';
  static String text_2 = 'Get to know how to read and interpret the graphs '
      'that is a summary of how your child uses his device';
  static String text_3 = 'Get to know how to read and interpret the graphs '
      'that is a summary of how your child uses his device';
  static String text_4 = 'Get to know how to read and interpret the graphs '
      'that is a summary of how your child uses his device';
}

class Png {
  static Image google = Image.asset('images/google-logo.png');
  static Image info1 = Image.asset(
    'images/png/undraw_1.png',
  );
  static Image info2 = Image.asset(
    'images/png/undraw4.png',
  );
  static Image info3 = Image.asset(
    'images/png/undraw3.png',
  );
  static Image facebook = Image.asset(
    'images/facebook-logo.png',
    color: CustomColors.indigoDark,
  );
}
