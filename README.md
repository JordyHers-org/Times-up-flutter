# Time's Up


>Time's Up is a mobile application developed using flutter to monitor the time kids spend on screen.
So far the app is only available on Android. The app can't run on iOS devices.The application has for sole purpose to
track and record the data from the child's device and send it to parents. The application does not violate the privacy policies
settled for user, and doesn't collect data for third parties companies.

## Onboarding Screen
<img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897259-af5ed4b4-8bdc-4460-80c7-1b83d797d079.png"> <img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897294-e71daa79-343b-4c39-b8c4-0181449ada27.png"> <img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897320-73528e2d-26f8-41f7-ab42-1b7e73cc7d06.png">



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

Instead, they watch some controllers that extend the `StateNotifier` class (using Riverpod).

This allows to map the data from the layer above to `AsyncValue` objects that can be mapped to the appropriate UI states (data, loading, error).

## Packages in use

- [firebase auth](https://pub.dev/packages/firebase_auth) for authentication
- [provider](https://pub.dev/packages/provider) for state management
- [algolia](https://pub.dev/packages/algolia) for backend search logic
- [easy location](https://pub.dev/packages/easy_location) for tracking locations
- [geo_locator](https://pub.dev/packages/geo_locator) for Lat and long values
- [cached_network_image](https://pub.dev/packages/cached_network_image) for caching images
- [app_usage](https://pub.dev/packages/app_usage) for app usage data


## Login Parent

> The first step is to log in the parent. Then Location permission we be asked and needs to be enabled.

<img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897543-4d48ee61-503f-4415-bf30-fe8321143df9.png"> <img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897485-86a199b6-e8d7-4111-98e1-f9a56fa91a7c.png"> <img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897562-f0aa6264-6d71-441f-b732-4336d19539ca.png">



## Parent side

>First the parent downloads the app on his android device.
To explain in a few details, the first step of the application is the Splash screen.
A splash screen will present a landing page. In this case, suppose the login is a parent. J
ust touch the Parent DEVICE button for the parent. After that, you will be redirected to a login page.
There are currently 4 possible input options. See Figure (4.2).

``` dart
- SIGN IN WITH EMAIL
- LOGIN WITH FACEBOOK 
-  SIGN IN WITH GOOGLE
- SIGN IN ANONYMOUS
```

<img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897672-26bdf5a3-d2e4-475e-8966-ef5216bd9f5a.png"> <img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897692-5c884f1b-7452-49ed-9705-41d6702d5514.png"> 

## Child's details page

><img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170897989-fc598995-c215-4292-91ef-3a242348dc1b.png"> <img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898002-2951e3cc-ef13-415c-ac40-9f12f001cb5c.png">


## Registering the new child's device

>Now the next step is to add a new sub device. Each user can only add a child device to the database as a sub- collection therefore does not have access to all stored child devices. Moreover each parent will be able to show only their child.
To achieve this a FloatingActionButton (+) is available on the Home page. This action will then open a page where you can add the child's picture, name, and email. Although email remains optional, it's always a good idea to keep an email.

<img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898921-b4045131-62f8-4df9-a34d-767aa99e18a9.jpeg"> <img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898969-ee2ac8eb-990f-4cdc-b936-c41a7cd4a5f3.jpeg"> <img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170899020-42aaa9cb-cf06-4580-b47a-efc767d747eb.jpeg"><img width="215" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170899070-ca7abdef-accb-4f81-a470-f07b17133f1c.jpeg">


### Database State at this step
<img width="1309" alt="Screen Shot 2022-05-30 at 03 55 19" src="https://user-images.githubusercontent.com/49708438/170899554-a6dcd93b-3db6-4c35-a7cf-c6d4e90e04b1.png">


## Child's side

>The parent must then log into the child's device with their credentials (email and password). Then the parent would have to enter the child’s unique key displayed in red (see fig.4.4-4). As soon as the child is verified, the device's location, TokenID and App List will be retrieved and added to Firebase.

<img width="315" alt="Screen Shot 2022-01-15 at 16 04 41" src="https://user-images.githubusercontent.com/49708438/170900224-4432f103-4719-4653-8d48-9be54b58aeb5.jpeg"><img width="315" alt="Screen Shot 2022-01-15 at 16 04 41" src="https://user-images.githubusercontent.com/49708438/170900229-a3728616-195b-4690-9f54-3bbf1e7d0901.jpeg"><img width="315" alt="Screen Shot 2022-01-15 at 16 04 41" src="https://user-images.githubusercontent.com/49708438/170900455-4160e63a-3952-4d78-a2d1-ccd401ef698c.jpeg">




>Database State at this step
<img width="1305" alt="Screen Shot 2022-05-30 at 04 02 59" src="https://user-images.githubusercontent.com/49708438/170900031-8be98721-25db-4165-9c6c-7a04ce653b0c.png">

### Notification Page

>The notification page will essentially allow the parent to send messages to the child's device. There are currently only two pre-written messages. HOMEWORK TIME and GO TO BED. Of course, it will be possible to customize these messages shortly. As soon as the parent taps the button a new message is written to the Firebase database. Therefore, it triggers a cloud function that will send the text message to the Token ID corresponding to the device. The system working behind as the backend is entirely handled by CloudFunction of the Firebase database. To achieve this a single javascript function was written and deployed.

<img width="507" alt="Screen Shot 2022-01-15 at 16 08 38" src="https://user-images.githubusercontent.com/49708438/149622900-03ea5412-43b6-4b17-a5d0-838b9b027042.png">

### Setting Page

> Note that some of the settings have not been implemented in the public version of the repo.

<img width="315" alt="Screen Shot 2022-05-10 at 19 51 51" src="https://user-images.githubusercontent.com/49708438/170898009-c18ee423-e47d-4d41-8f60-ae82ad97150a.png"> 



**Note**: to use the API you'll need to register an account and obtain your own API key. This can be set via `--dart-define` or inside `lib/src/api/api_keys.dart`.

### [LICENSE: MIT](LICENSE.md)
