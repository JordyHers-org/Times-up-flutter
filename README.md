# Time's Up 🚼


Time's Up is a mobile application developed using flutter to monitor the time kids spend on screen.
So far the app is only available on Android. The app can't run on iOS devices.The application has for sole purpose to
track and record the data from the child's device and send it to parents. The application does not violate the privacy policies
settled for user, and doesn't collect data for third parties companies. 



<h6> Live App Demo </h6>

https://user-images.githubusercontent.com/49708438/171131514-2da559c6-53b8-468a-b447-db69eb233d59.mov



### The first version doesn't contain all the features. Some features have been hardcoded on purpose. In order to have the code, please approach the author.🔥
This version includes 
-  Location Tracking
- App Usage
- Notification

 **Premium** ✅

- App Icons 📱
- App Usage Metrics 📈
- Setting page (Update Profile) 🚹
- Contact Us page📩
- Dark Mode 🌘
- Customize Notification 📳
- Battery Level 📶
- Marker image (Child's Picture) on Map 🗺
- Email follow up for weekly report 📨



## Onboarding Screen
<img width="215" alt="Onboarding Screen" src="https://user-images.githubusercontent.com/49708438/170897259-af5ed4b4-8bdc-4460-80c7-1b83d797d079.png"> <img width="215" alt="OnboardingScreen2" src="https://user-images.githubusercontent.com/49708438/170897294-e71daa79-343b-4c39-b8c4-0181449ada27.png"> <img width="215" alt="OnboardingScreen3" src="https://user-images.githubusercontent.com/49708438/170897320-73528e2d-26f8-41f7-ab42-1b7e73cc7d06.png">


## Run Project on your device

### Step_1
```dart
> flutter create parental_control
```



### Step_2
```dart
> git clone project and copy files to new projects 
```



### Step_3 
> Add the necessary permissions to /android/app/src/main/AndroidManifest.xml
```dart
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission
        android:name="android.permission.PACKAGE_USAGE_STATS"
        tools:ignore="ProtectedPermissions" />
    <uses-permission
        android:name="android.permission.ACCESS_FINE_LOCATION"
        />
    <uses-permission
        android:name="android.permission.ACCESS_COARSE_LOCATION"
        />
```

> Add your APi Key to project /android/app/src/main/AndroidManifest.xml

> Create api Google Map key on Google cloud Console to launch the map. [Set Up Google map in Flutter](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#5)

```dart
  <meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="<Your Api Key>" />
```

### Step_4

Create a new firebase project and add your credentials and SHA-1 and SHA-256 Keys 

Then Add google.json file to android / app folder  [Add Firebase to your flutter app](https://firebase.google.com/docs/flutter/setup?platform=android)




## Supported Features

- [x] Location Tracking
- [x] App Usage Data
- [x] CloudFunctions
- [x] Messaging
- [x] PushNotifications



## App Architecture

The app is composed by two main layers.



### Presentation Layer

This layer holds all the widgets, along with their controllers.

Widgets do not communicate directly with the repository.

Instead, they watch some controllers that extend the `StateNotifier`. The busineess Logic 

used to control pages is [BLoC](https://bloclibrary.dev/#/). It is the perfect tool in 

this use case as BLoC allows to emit states using Specific ENUMS cases.


## Packages in use

- [firebase auth](https://pub.dev/packages/firebase_auth) for authentication
- [provider](https://pub.dev/packages/provider) for state management
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for Child's page management
- [easy location](https://pub.dev/packages/easy_location) for tracking locations
- [geo_locator](https://pub.dev/packages/geo_locator) for Lat and long values
- [cached_network_image](https://pub.dev/packages/cached_network_image) for caching images
- [app_usage](https://pub.dev/packages/app_usage) for app usage data
- [shared_preferences](https://pub.dev/packages/shared_preferences) for String and bool caching



## Login Parent 👨‍👩‍

The first step is to log in the parent. Then Location permission we be asked and needs to be enabled.

<img width="215" alt="LoginParent1" src="https://user-images.githubusercontent.com/49708438/170897543-4d48ee61-503f-4415-bf30-fe8321143df9.png"> <img width="215" alt="LoginParent2" src="https://user-images.githubusercontent.com/49708438/170897485-86a199b6-e8d7-4111-98e1-f9a56fa91a7c.png"> <img width="215" alt="LoginParent3" src="https://user-images.githubusercontent.com/49708438/170897562-f0aa6264-6d71-441f-b732-4336d19539ca.png">





## Parent side 👨‍👩‍👦

First the parent downloads the app on his android device.To explain in a few details,

the first step of the application is the Splash screen. A splash screen will present a 

landing page. In this case, suppose the login is a parent. Just touch the Parent DEVICE

button for the parent.After that, you will be redirected to a login page. 

There are currently 3 possible input options.See Figure (4.2).

``` dart
- Sign in with email
- Sign in with facebook
- Sign in with google
```

<img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897672-26bdf5a3-d2e4-475e-8966-ef5216bd9f5a.png"> <img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897692-5c884f1b-7452-49ed-9705-41d6702d5514.png"> 



## Child's details page 🚸

<img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897989-fc598995-c215-4292-91ef-3a242348dc1b.png"> <img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898002-2951e3cc-ef13-415c-ac40-9f12f001cb5c.png">




## Registering the new child's device

Now the next step is to add a new sub device. Each user can only add a child device 

to the database as a sub- collection therefore does not have access to all stored 

child devices. Moreover each parent will be able to show only their child. To achieve 

this a FloatingActionButton (+) is available on the Home page. This action will then 

open a page where you can add the child's picture, name, and email. Although email 

remains optional, it's always a good idea to keep an email.

<img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898921-b4045131-62f8-4df9-a34d-767aa99e18a9.jpeg"> <img width="215" height= "450" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898969-ee2ac8eb-990f-4cdc-b936-c41a7cd4a5f3.jpeg"> <img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170899020-42aaa9cb-cf06-4580-b47a-efc767d747eb.jpeg"><img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170899070-ca7abdef-accb-4f81-a470-f07b17133f1c.jpeg">


### Database State at this step 🗂 

At this step the database contains null parameters. The location-(GeoPoint) along with

The list of app used with all the data. More than that, The device Token got from

[Firebase Messaging](https://medium.com/@jun.chenying/flutter-tutorial-part3-push-notification-with-firebase-cloud-messaging-fcm-2fbdd84d3a5e) they are 

All set to NuLL and will remain null until the child's device is registered.

<img width="1009" alt="Screen Shot 2022-05-30 at 03 55 19" src="https://user-images.githubusercontent.com/49708438/170899554-a6dcd93b-3db6-4c35-a7cf-c6d4e90e04b1.png">


## Child's side

The parent must then log into the child's device with their credentials

(email and password). Then the parent would have to enter the child’s unique

key displayed in red (see fig.4.4-4). As soon as the child is verified,

the device's location, TokenID and App List will be retrieved and added to Firebase.

<img width="215" alt="Screen Shot 2022-01-15 at 16 04 41" src="https://user-images.githubusercontent.com/49708438/170900224-4432f103-4719-4653-8d48-9be54b58aeb5.jpeg"><img width="215" alt="Screen Shot 2022-01-15 at 16 04 41" src="https://user-images.githubusercontent.com/49708438/170900229-a3728616-195b-4690-9f54-3bbf1e7d0901.jpeg"><img width="215" alt="Screen Shot 2022-01-15 at 16 04 41" src="https://user-images.githubusercontent.com/49708438/170900455-4160e63a-3952-4d78-a2d1-ccd401ef698c.jpeg">


<h3> Database State at this step 🗂 </h3>

The missing parameters have been successfully updated. As you can see

All the data are taken from the child device and update the the database via 

StreamSubsubscription

<img width="1005" alt="Screen Shot 2022-05-30 at 04 02 59" src="https://user-images.githubusercontent.com/49708438/170900031-8be98721-25db-4165-9c6c-7a04ce653b0c.png">

### Notification Page

The notification page will essentially allow the parent to send messages to the 

child's device. There are currently only two pre-written messages.**HOMEWORK TIME** and

**GO TO BED**. Of course, it will be possible to customize these messages shortly. As soon

as the parent taps the button a new message is written to the Firebase database. 

Therefore, it triggers a cloud function that will send the text message to the Token ID 

corresponding to the device. The system working behind as the backend is entirely handled by

CloudFunction of the Firebase database. To achieve this a single javascript function was

written and deployed.

<img width="315" alt="Screen Shot 2022-01-15 at 16 08 38" src="https://user-images.githubusercontent.com/49708438/149622900-03ea5412-43b6-4b17-a5d0-838b9b027042.png">

### Setting Page

Note that some of the settings have not been implemented in the public version of the repo.

<img width="215" alt="SettigPage" src="https://user-images.githubusercontent.com/49708438/170898009-c18ee423-e47d-4d41-8f60-ae82ad97150a.png"> 


***NOTE THAT THE PROJECT HAS NOT BEEN MOVE TO NULLL SAFETY YET***

### [LICENSE: MIT](LICENSE.md)
