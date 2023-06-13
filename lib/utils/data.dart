import 'package:flutter/material.dart';

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
}

class BottomNavigationData {
  static Map<int, BottomNavigationBarItem> items = {
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
}
