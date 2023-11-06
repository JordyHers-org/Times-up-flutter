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
  static InfoData text_1 = InfoData(
      'Get to know how to read and interpret the graphs '
          'that is a summary of how your child uses his device',
      '''
  
      Get to know how to read and interpret the graphs. These visual representations offer valuable insights into your child's device usage patterns. Here's a summary to help you understand and utilize these graphs effectively:

  - Usage Trends: Monitor the trends in device usage over time. Look for patterns, spikes, or declines in usage that may indicate changing habits or activities.

  - Peak Usage Times: Identify the times when device usage is at its peak. Is it during school hours, after school, or late at night? Understanding these patterns can guide discussions about appropriate device usage times.

  - App Usage Breakdown: Analyze which apps your child uses the most. Are they educational apps, social media, games, or others? This breakdown can highlight their interests and help in managing app access.

  - Duration of Use: Explore the duration of each device usage session. Excessive continuous usage might necessitate breaks to prevent eye strain and maintain a healthy balance.

  - Screen Unlocks: Keep track of how often your child unlocks the device. Frequent unlocks may indicate distractions or interruptions in their activities.

  To interpret the graphs effectively:

  - Set Limits and Boundaries: Based on the insights gained, set appropriate usage limits and boundaries for your child's device usage.

  - Encourage Productive Use: Encourage the use of educational apps or creative activities during peak usage times to ensure productive screen time.

  - Engage in Dialogue: Use the data as a conversation starter. Discuss the graphs with your child, allowing them to express their perspective and jointly establish healthy device usage habits.

  - Adjust and Adapt: Periodically review the graphs and adjust your approach accordingly. As your child grows and their needs change, adapt the usage guidelines to suit their evolving routine.

  Understanding these usage graphs empowers you to make informed decisions, promoting a balanced approach to technology and fostering a healthy digital lifestyle for your child.
      1
''');

  static InfoData text_2 = InfoData(
      'Get to know how to send messages and notifications '
          'to your child device',
      '''
   Get to know how to send messages and notifications to your child's device. 
  Effectively communicating with your child through messages and notifications 
  is essential for staying connected and ensuring their safety and well-being. 
  
  
  Here's a guide to help you navigate this process and maintain a healthy 
  line of communication:

  - Choose the Right Medium: Decide on the appropriate platform for sending messages and notifications to your child. It could be a secure messaging app, the device's built-in messaging system, or a family communication app designed for parental controls.

  - Establish Guidelines and Expectations: Set clear guidelines for communication. Discuss when it's appropriate to send messages, the type of information to convey, and the expected response time. This helps in managing expectations and maintaining a respectful communication flow.

  - Prioritize Important Information: Use messages and notifications primarily for important updates, reminders, or urgent communication. Avoid excessive or unnecessary messages that can be distracting or overwhelming for your child.

  - Use Clear and Concise Language: When composing messages, ensure that the language is clear and easy for your child to understand. Avoid using jargon or complex terms that might cause confusion.

  - Respect Privacy and Boundaries: Be mindful of your child's privacy. Avoid invasive or overly controlling messages. Respect their space and communicate in a way that shows trust and understanding.

  To send effective messages and notifications:

  - Be Encouraging and Supportive: Use messages to provide encouragement, praise, or motivation. Share positive feedback to boost their confidence and acknowledge their achievements.

  - Utilize Scheduled Messages: Consider scheduling messages for important events, reminders for tasks, or words of encouragement. Scheduled messages can be a helpful tool for maintaining consistent communication.

  - Emergency Notifications: Ensure you have a clear system in place for emergency notifications. In case of urgent matters, both you and your child should be aware of how to communicate and respond promptly.

  - Feedback and Open Dialogue: Encourage your child to provide feedback on the way you communicate. Keep the lines of communication open, allowing them to express their thoughts and preferences regarding messaging and notifications.

  Communicating effectively with your child through messages and notifications is crucial for maintaining a strong and healthy parent-child relationship. Following these guidelines and strategies will help foster a positive and respectful channel of communication. 2
''');

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
