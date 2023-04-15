import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/models/notification_model.dart';
import 'package:parental_control/services/api_path.dart';
import 'package:parental_control/services/app_usage_service.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/firestore_service.dart';
import 'package:parental_control/services/geo_locator_service.dart';

abstract class Database {
  Future<void> setChild(ChildModel model);

  Future<void> liveUpdateChild(ChildModel model, int tick);

  Future<void> updateChild(ChildModel model);

  Future<void> deleteChild(ChildModel model);

  Future<void> deleteNotification(String id);

  Stream<List<ChildModel>> childrenStream();

  Future<void> setNotification(
      NotificationModel notification, ChildModel model);

  Stream<List<NotificationModel>> notificationStream({String childId});

  Stream<ChildModel> childStream({required String childId});

  Future<ChildModel> getUserCurrentChild(
      String name, String key, GeoPoint latLong);
}

// String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({
    required this.uid,
    this.auth,
  }) : assert(uid != null);

  final String uid;
  final AuthBase? auth;
  ChildModel? _child;

  @override
  ChildModel get currentChild => _child!;

  final _service = FirestoreService.instance;
  AppUsageService apps = AppUsageService();
  GeoLocatorService geo = GeoLocatorService();

  @override
  Future<ChildModel> getUserCurrentChild(
      String name, String key, GeoPoint latLong) async {
    final user = auth?.currentUser?.uid;
    final token = await auth?.setToken();
    await apps.getAppUsageService();
    await setTokenOnFireStore({'childId': '$key', 'device_token': '$token'});

    String _currentChild;
    String _email;
    String _image;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('child')
        .doc(key)
        .get()
        .then((doc) async {
      if (doc.exists) {
        _email = doc.data()!['email'];
        _currentChild = doc.data()!['name'];
        _image = doc.data()!['image'];
        print('------------------------------------------------------');
        print(' User : $user \n');
        print(' ---------------- We found this as a match --------');
        print(doc['name']);
        print('Name : $_currentChild');
        print('Image : $_image');
        print('Email : $_email');
        print('Unique Key : $key');

        _child = ChildModel(
            id: doc.id,
            name: _currentChild,
            email: _email,
            image: _image,
            position: latLong,
            appsUsageModel: apps.info,
            token: token);

        await setChild(_child!);
        return _child;
      } else {
        print(' NO SUCH FILE ON DATABASE ');
      }
    });
    print(_child);
    return _child!;
  }

  @override
  Future<void> liveUpdateChild(ChildModel model, value) async {
    final user = auth?.currentUser?.uid;
    await apps.getAppUsageService();
    var point = await geo.getInitialLocation();
    var currentLocation = GeoPoint(point.latitude, point.longitude);

    print('The user is $user and the Child Id: ${model.id}');
    print(
        ' DEBUG: FROM DATABASE ===> Last location taken is longitude : ${point.longitude} , latitude :${point.latitude}');
    print(' DEBUG: APP USAGE ==> ${apps.info}');

    if (model.id == 'D9FBAB88') {
      print('Choosing random Position for ${model.id}');
      // generates a new Random object
      var positions = <GeoPoint>[
        GeoPoint(41.025576, 28.663767),
        GeoPoint(41.021463, 28.661506),
        GeoPoint(41.010192, 28.665780),
        GeoPoint(41.008564, 28.672471),
      ];
      // generate a random index based on the list length
      // and use it to retrieve the element
      var randomPosition = (positions..shuffle()).first;
      print('The random location is $randomPosition');
      _child = ChildModel(
        id: model.id,
        name: model.name,
        email: model.email,
        token: model.token,
        position: randomPosition,
        appsUsageModel: apps.info,
        image: model.image,
      );
    } else {
      _child = ChildModel(
        id: model.id,
        name: model.name,
        email: model.email,
        token: model.token,
        position: currentLocation,
        appsUsageModel: apps.info,
        image: model.image,
      );
    }

    await updateChild(_child!);
  }

  @override
  Future<void> setChild(ChildModel model) => _service.setData(
        path: APIPath.child(uid, model.id),
        data: model.toMap(),
      );

  @override
  Future<void> updateChild(ChildModel model) => _service.updateData(
        path: APIPath.child(uid, model.id),
        data: model.toMap(),
      );

  @override
  Future<void> setNotification(
      NotificationModel notification, ChildModel child) async {
    await _service.setNotificationFunction(
        path: APIPath.notificationsStream(uid, child.id),
        data: notification.toMap());
  }

  Future<void> setTokenOnFireStore(Map<String, dynamic> token) async {
    await _service.setNotificationFunction(
        path: APIPath.deviceToken(), data: token);
  }

  @override
  Future<void> deleteChild(ChildModel model) async {
    await _service.deleteData(path: APIPath.child(uid, model.id));
  }

  @override
  Future<void> deleteNotification(String id) async {
    await _service.deleteData(path: APIPath.notifications(uid, id));
  }

  @override
  Stream<ChildModel> childStream({required String childId}) =>
      _service.documentStream(
        path: APIPath.child(uid, childId),
        builder: (data, documentId) => ChildModel.fromMap(data, documentId),
      );

  @override
  Stream<List<NotificationModel>> notificationStream({String? childId}) {
    return _service.notificationStream(
      path: APIPath.notificationsStream(uid, childId ?? ''),
      builder: (data, documentId) =>
          NotificationModel.fromMap(data, documentId),
    );
  }

  @override
  Stream<List<ChildModel>> childrenStream() => _service.collectionStream(
        path: APIPath.children(uid),
        builder: (data, documentId) => ChildModel.fromMap(data, documentId),
      );
}
