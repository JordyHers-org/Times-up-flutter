import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parental_control/common_widgets/show_logger.dart';
import 'package:parental_control/models/child_model/child_model.dart';
import 'package:parental_control/models/notification_model/notification_model.dart';
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

  Stream<List<NotificationModel>> notificationStream({String childId});

  Stream<ChildModel> childStream({required String childId});

  Future<void> setNotification(
    NotificationModel notification,
    ChildModel model,
  );

  Future<ChildModel> getUserCurrentChild(
    String name,
    String key,
    GeoPoint latLong,
  );
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({
    required this.uid,
    this.auth,
  });

  final String uid;
  final AuthBase? auth;
  ChildModel? _child;

  ChildModel get currentChild => _child!;

  final _service = FirestoreService.instance;
  AppUsageService apps = AppUsageService();
  GeoLocatorService geo = GeoLocatorService();

  @override
  Future<void> setChild(ChildModel model) => _service.setData(
        path: APIPath.child(uid, model.id),
        data: model.toJson(),
      );

  @override
  Future<void> updateChild(ChildModel model) => _service.updateData(
        path: APIPath.child(uid, model.id),
        data: model.toJson(),
      );

  @override
  Future<void> setNotification(
    NotificationModel notification,
    ChildModel child,
  ) async {
    await _service.setNotificationFunction(
      path: APIPath.notificationsStream(uid, child.id),
      data: notification.toJson(),
    );
  }

  Future<void> setTokenOnFireStore(Map<String, dynamic> token) async {
    await _service.setNotificationFunction(
      path: APIPath.deviceToken(),
      data: token,
    );
  }

  @override
  Future<void> deleteChild(ChildModel model) async {
    await _service.deleteData(
      path: APIPath.child(uid, model.id),
      image: model.image,
    );
  }

  @override
  Future<void> deleteNotification(String id) async {
    await _service.deleteData(path: APIPath.notifications(uid, id));
  }

  @override
  Stream<ChildModel> childStream({required String childId}) =>
      _service.documentStream(
        path: APIPath.child(uid, childId),
        builder: (data, documentId) => ChildModel.fromJson(data),
      );

  @override
  Stream<List<NotificationModel>> notificationStream({String? childId}) {
    return _service.notificationStream(
      path: APIPath.notificationsStream(uid, childId ?? ''),
      builder: (data, documentId) => NotificationModel.fromJson(data),
    );
  }

  @override
  Stream<List<ChildModel>> childrenStream() => _service.collectionStream(
        path: APIPath.children(uid),
        builder: (data) => ChildModel.fromJson(data),
      );

  @override
  Future<void> liveUpdateChild(ChildModel model, value) async {
    await apps.getAppUsageService();
    var point = await geo.getInitialLocation();
    var currentLocation = GeoPoint(point.latitude, point.longitude);

    _child = ChildModel(
      id: model.id,
      name: model.name,
      email: model.email,
      token: model.token,
      position: currentLocation,
      appsUsageModel: apps.info,
      image: model.image,
    );

    await updateChild(_child!);
  }

  @override
  Future<ChildModel> getUserCurrentChild(
    String name,
    String key,
    GeoPoint latLong,
  ) async {
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

        _child = ChildModel(
          id: doc.id,
          name: _currentChild,
          email: _email,
          image: _image,
          position: latLong,
          appsUsageModel: apps.info,
          token: token,
        );

        await setChild(_child!);
        return _child;
      } else {
        JHLogger.$.e(' NO SUCH FILE ON DATABASE ');
      }
    });
    JHLogger.$.d(' NO SUCH FILE ON DATABASE ');
    return _child!;
  }
}
