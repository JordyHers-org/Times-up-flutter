import 'package:flutter/material.dart';
import 'package:times_up_flutter/l10n/l10n.dart';
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
  static Map<int, BottomNavigationBarItem> items(BuildContext context) => {
        0: BottomNavigationBarItem(
          label: AppLocalizations.of(context).dashboard,
          icon: const Icon(
            Icons.dashboard_customize_outlined,
          ),
        ),
        1: BottomNavigationBarItem(
          label: AppLocalizations.of(context).notification,
          icon: const Icon(
            Icons.notifications_on_outlined,
          ),
        ),
        2: BottomNavigationBarItem(
          label: AppLocalizations.of(context).location,
          icon: const Icon(
            Icons.location_history,
          ),
        ),
      };
}

class MockData {
  static InfoData text_1(BuildContext context) =>
      InfoData(context.l10n.infoTitle, context.l10n.infoText);

  static InfoData text_2(BuildContext context) =>
      InfoData(context.l10n.infoMessageTitle, context.l10n.infoMessageText);

  static InfoData text_3 =
      InfoData('Get to know all the tips and tricks to monitor your child', '''
  Get to know all the tips and tricks to monitor your child. Monitoring your child's activities is essential for their safety, well-being, and ensuring responsible device usage. Here's a comprehensive guide to help you effectively monitor your child while respecting their privacy and promoting a healthy digital lifestyle:

  - Open Communication: Establish an open line of communication with your child. Discuss the importance of monitoring and be transparent about your intentions. Encourage them to share their concerns and experiences.

  - Set Clear Expectations: Clearly define the rules and expectations regarding device usage, online behavior, and the type of activities you'll monitor. Ensure your child understands the consequences of violating these guidelines.

  - Use Parental Control Apps: Explore parental control apps that provide various monitoring features, such as screen time tracking, app usage monitoring, and website blocking. Choose an app that aligns with your monitoring needs and your child's age.

  - Monitor Social Media Activity: Keep an eye on your child's social media interactions. Check their friend list, posts, comments, and messages to ensure they are engaging with a safe and respectful online community.

  - Review Browser History: Periodically review your child's browser history to see the websites they've visited. This helps you understand their interests and online activities.

  To effectively monitor your child:

  - Educate on Online Safety: Teach your child about online safety, privacy, and the potential risks of sharing personal information. Equip them with the knowledge to make responsible decisions online.

  - Regular Check-ins: Schedule regular check-ins to discuss their online experiences, challenges, and any concerns they might have. This helps you stay informed and address issues promptly.

  - Encourage Balanced Use: Monitor the duration and timing of device usage to ensure a healthy balance between screen time and other activities such as physical exercise, reading, and social interactions.

  - Respect Privacy: While monitoring is crucial, respect your child's privacy by not invading their personal space or excessively monitoring every action. Maintain trust and open communication.

  By implementing these tips and tricks, you can monitor your child effectively, ensuring their safety and promoting responsible device usage. Balancing monitoring with open communication and respect is key to fostering a healthy parent-child relationship in the digital age. 3
''');

  static InfoData text_4 = InfoData(
      'Get to know how to control what your child '
          'is listening to anytime anywhere.',
      '''
  Get to know how to control what your child is listening to anytime, anywhere. 
  Ensuring that your child is exposed to age-appropriate and safe audio content is 
  crucial for their development and well-being.
  
   Here's a comprehensive guide to 
  help you effectively control and manage what your child is listening to:

  - Choose Suitable Platforms: Opt for audio platforms that offer parental controls and a variety of age-appropriate content. Look for platforms that allow you to create child profiles and curate content based on your child's age and interests.

  - Explore Parental Control Features: Familiarize yourself with the parental control features available on the chosen audio platforms. These features typically allow you to block or restrict access to specific content categories or individual episodes.

  - Create Playlists and Channels: Create custom playlists or channels for your child, containing content that is educational, entertaining, and in line with your family's values. Regularly update and curate these playlists to keep the content fresh and engaging.

  - Review Content Together: Listen to selected episodes or tracks together with your child. This allows you to gauge the appropriateness of the content and discuss any themes or messages that may need further clarification or guidance.

  To effectively control what your child is listening to:

  - Monitor Listening Habits: Keep an eye on the type of content your child is listening to and how frequently. If you notice any content that raises concerns, address it with your child and consider adjusting their access accordingly.

  - Educate on Responsible Listening: Teach your child about responsible and safe listening habits. Discuss the importance of choosing age-appropriate content and the potential impact of audio content on their thoughts and behavior.

  - Encourage Communication: Encourage your child to communicate with you if they come across any content that makes them uncomfortable or if they have questions. Maintain an open dialogue about what they're listening to.

  - Set Listening Time Limits: Define specific time limits for audio content consumption. Encourage breaks and diversify their activities to ensure a healthy balance between listening and other activities.

  By following these tips and strategies, you can effectively control what your child is listening to, promoting a safe and enriching audio experience for them. It's essential to balance control with education and communication to ensure a positive listening environment for your child. 4
''');
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

class InfoData {
  InfoData(this.title, this.content);

  final String title;
  final String content;
}
