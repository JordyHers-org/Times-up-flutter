
<img width="1023" alt="Screenshot 2023-06-06 at 08 22 55" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/fb33eb58-8fad-4f75-a2c5-9c892525c294">




## NEW FEATURES

Time's Up is a mobile application developed using `flutter` to monitor the time kids
spend on screen.So far the app is only available on Android. The app can't run on iOS devices.
The application has for sole purpose to track and record the data from the child's
device and send it to parents. The application does not violate the `privacy policies`
settled for user, and doesn't collect data for third parties companies.

####  🚀 V2.0.0

##### Planned Features:
- App Icons 📱
- App Usage Metrics 📈
- Setting page (Update Profile) 🚹
- Contact Us page📩
- Dark Mode 🌘
- Customize Notification 📳
- Battery Level 📶
- Marker image (Child's Picture) on Map 🗺
- Email follow up for weekly report 📨
- Location Tracking 📍
- Notification 🔔


## Screenshot

|  v2.0.0 | v2.0.0 |
| ------------- |------------- |
| <img width="215" alt="v2.0.0" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/1354eed0-dc20-4083-9b24-fe7fc26649fd"> | <img width="215" alt="v2.0.0" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/496fcdb6-adf9-48d3-9413-b4e2c781a3d7"> 



## Presentation Layer

This layer holds all the widgets, along with their controllers.Widgets do not communicate directly with <br>
the repository.Instead, they watch some controllers that extend the `StateNotifier`.The busineess Logic used <br>
to control pages is [BLoC](https://bloclibrary.dev/#/). It is the perfect tool in this use case as BLoC allows to emit states using <br>
Specific ENUMS cases.


## Packages

- [firebase auth](https://pub.dev/packages/firebase_auth) for authentication
- [provider](https://pub.dev/packages/provider) for state management
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for Child's page management
- [easy location](https://pub.dev/packages/easy_location) for tracking locations
- [geo_locator](https://pub.dev/packages/geo_locator) for Lat and long values
- [cached_network_image](https://pub.dev/packages/cached_network_image) for caching images
- [shared_preferences](https://pub.dev/packages/shared_preferences) for String and bool caching
- [share_plus](https://pub.dev/packages/share_plus) for sharing Child's code

## Contribution
To have access to fireabse and all necessary credentials and 
To contribute to the project join the discord server:
Jordyhers [Discord- JordyHers](https://discord.gg/e4ppDx9Zcy)


## License 



