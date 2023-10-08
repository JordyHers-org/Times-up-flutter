
<img width="1023" alt="Screenshot 2023-06-06 at 08 22 55" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/fb33eb58-8fad-4f75-a2c5-9c892525c294">

## NEW FEATURES 🚀 v2.0.0

Time's Up is a mobile application developed using `flutter` to monitor the time kids
spend on screen.So far the app is only available on Android. The app can't run on iOS devices.
The application has for sole purpose to track and record the data from the child's
device and send it to parents. The application does not violate the `privacy policies`
settled for user, and doesn't collect data for third parties companies.

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


## Application Feature: Parent Side



| | | |
|-|-|-|
| <img width="215" alt="Onboarding" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/cfdd94f2-9e59-40c4-a618-f8d5ca24fb71"> | <img width="215" alt="Sign_in_page" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/f93770ee-5516-4851-adc5-4ef71938316b"> | <img width="215" alt="child_list_page" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/fa161844-7cc7-4189-bab3-230d3da41dd4"> 
| <img width="215" alt="ChildDetailsPage" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/2bc18783-d2c3-4cc3-8c59-4e04fabd256b"> | <img width="215" alt="ChildNotificationRemoval" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/f6be1a2e-9218-4eec-b3bb-426dce5cf1ab"> | <img width="215" alt="GuidedTour" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/9e14dda2-6694-4719-9eea-ec8cbb465de9"> 
| <img width="215" alt="NotificationSending" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/32a04552-a2a2-4806-b861-59c2eda0273d"> | <img width="215" alt="ChildLocation" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/5e12904a-9d70-448f-ae2f-908e1574c8e8"> | <img width="215" alt="settings_page" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/01b33fb7-f7d9-4b6c-80b1-a0d9ab489780"> |

## Application Feature: Child Side



| | |
|-|-|
| <img width="215" alt="Onboarding" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/ad9134b9-1eb7-4b42-ab19-de04244e8c25"> | <img width="215" alt="Onboarding" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/52576c8a-46de-4caf-9126-75589ca39e28"> |  
| <img width="215" alt="SetUpChild" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/240a90e4-54d5-49aa-89eb-985c887b3604"> | <img width="215" alt="AppUsageList" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/6afa03ea-0195-4b64-b394-531397897252"> | 



## Tech Stack

- **Front End**: Flutter
- **Back End**: Firebase (Firestore, Cloud Functions)
- **Push Notifications**: Enabled via Cloud Functions triggered in Firebase
- **Authentication**: Firebase Auth



## Packages

- [firebase auth](https://pub.dev/packages/firebase_auth) for authentication
- [provider](https://pub.dev/packages/provider) for state management
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for Child's page management
- [easy location](https://pub.dev/packages/easy_location) for tracking locations
- [geo_locator](https://pub.dev/packages/geo_locator) for Lat and long values
- [cached_network_image](https://pub.dev/packages/cached_network_image) for caching images
- [shared_preferences](https://pub.dev/packages/shared_preferences) for String and bool caching
- [share_plus](https://pub.dev/packages/share_plus) for sharing Child's code



## Quick Start and Run

1. **Read The Branch naming convention**
   > <a href="https://docs.google.com/viewer?url=https://github.com/JordyHers-org/Times-up-flutter/files/12828818/how_to_create_a_branch.pdf">How to name a branch</a>

2. **Fork and Clone the Project**
   ```bash
   git clone https://github.com/JordyHers-org/Times-up-flutter.git
   cd Times-up-flutter/
   ```

3. **Install Flutter Version**
   > Install FVM via Homebrew and use Flutter version 3.7.12.
   ```bash
   
   brew install fvm
   fvm install 3.7.12
   ```

4. **Request Firebase Options File**
   > Request the Firebase options file from the Project Owner and place it in the appropriate location.

5. **Extra**
   > For child's pictures feel free to use any of the pictures available.

| | | |
|-|-|-|
| <img width="115" alt="Neymar" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/c04ab191-c498-4ca1-bdab-84111babe6b3"> | <img width="115" alt="Momo" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/db2f3dd2-2a09-4e82-b26b-50f860679f3f"> | <img width="115" alt="Gareth" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/8faee404-8fb4-497d-abaf-82576df91621"> 
| <img width="115" alt="Titi" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/48ab9c3d-e180-482f-a295-54a00b76607b"> | <img width="115" alt="Bruyne" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/fa620a3e-2450-4434-b84d-70afbacdc2ec"> | <img width="115" alt="Kylian" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/bb6c2be5-b8fc-4178-8794-2c0e6e1349db"> 
| <img width="115" alt="Leo" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/9a093894-06af-487e-8ca1-edf35c9ece03"> | <img width="115" alt="Sally" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/31155608-2cc2-4e3e-815c-07f90aa1c27a"> | <img width="115" alt="Harry" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/c9302548-564c-490a-b0a5-feb74d2113cf"> |


---

## Contributors
To have access to firebase and all necessary credentials and 
To contribute to the project join the discord server:
Jordyhers [Discord- JordyHers](https://discord.gg/e4ppDx9Zcy)

<img width="429" alt="Screenshot 2023-10-06 at 10 57 07" src="https://github.com/JordyHers-org/Times-up-flutter/assets/49708438/f3623f25-0cb7-49f0-8e5c-d6008b56d248">




