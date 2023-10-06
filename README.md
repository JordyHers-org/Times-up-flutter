
<img width="1023" alt="Screenshot 2023-06-06 at 08 22 55" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/fb33eb58-8fad-4f75-a2c5-9c892525c294">



## Tech Stack

- **Front End**: Flutter
- **Back End**: Firebase (Firestore, Cloud Functions)
- **Push Notifications**: Enabled via Cloud Functions triggered in Firebase
- **Authentication**: Firebase Auth

## Quick Start and Run

### Setup

1. **Fork and Clone the Project**
   ```bash
   git clone https://github.com/JordyHers-org/Times-up-flutter.git
   cd Times-up-flutter/
   ```

2. **Install Flutter Version**
   Install FVM via Homebrew and use Flutter version 3.7.12.
   ```bash
   
   brew install fvm
   fvm install 3.7.12
   ```

3. **Request Firebase Options File**
   Request the Firebase options file from the Project Owner and place it in the appropriate location.

3. **Extra**
   For child's pictures feel free to use any of the pictures available.
   
| | | |
|-|-|-|
| ![neymar](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/c04ab191-c498-4ca1-bdab-84111babe6b3) | ![momo](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/db2f3dd2-2a09-4e82-b26b-50f860679f3f) | ![gareth](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/8faee404-8fb4-497d-abaf-82576df91621) 
| ![titi](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/48ab9c3d-e180-482f-a295-54a00b76607b) | ![bruyne](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/fa620a3e-2450-4434-b84d-70afbacdc2ec) | ![kylian](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/bb6c2be5-b8fc-4178-8794-2c0e6e1349db) 
| ![leo](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/9a093894-06af-487e-8ca1-edf35c9ece03) | ![sally](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/31155608-2cc2-4e3e-815c-07f90aa1c27a) | ![harry](https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/c9302548-564c-490a-b0a5-feb74d2113cf) |



### Branch Naming Conventions
[how_to_create_a_branch.pdf](https://github.com/JordyHers-org/Times-up-flutter/files/12828818/how_to_create_a_branch.pdf)


#### Branch

- **Feature**: `feature/issueNumber-issueDescription`
- **Bugfix**: `bugfix/issueNumber-issueDescription`
- **Chore**: `chore/issueNumber-issueDescription`
- **Test**: `test/issueNumber-issueDescription`

Example: `feature/23-implement-login-button`

#### Commits

- **Feature**: `feat(#issueNumber) : issueDescription`
- **Fix**: `fix(#issueNumber) : issueDescription`
- **Test**: `test(#issueNumber) : issueDescription`
- **Chore**: `chore(#issueNumber) : issueDescription`

Example: `feat(#23) : implement login button`

---


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


## Video Demo


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



