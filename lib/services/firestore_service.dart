import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parental_control/common_widgets/show_logger.dart';
class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    Logging.logger.d('$path: $data');
    await reference.set(data);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    Logging.logger.d('$path: $data');
    await reference.update(data);
  }

  Future<void> setNotificationFunction({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference =
        FirebaseFirestore.instance.collection(path).doc(data['id']);
    Logging.logger.d('$path: $data');
    await reference.set(data);
  }

  Future<void> saveToken({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    // await FirebaseFirestore.instance.collection('Notifications').
    // doc().set({'message': 'HomeWork Time'});
    final reference = FirebaseFirestore.instance.collection(path).doc();
    Logging.logger.d('$path: $data');
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    Logging.logger.w('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    var query = FirebaseFirestore.instance.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }

      return result;
    });
  }

  Stream<List<T>> notificationStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    var query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<List<T>> notificationStreamChildPage<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    var query = FirebaseFirestore.instance.collection(path);
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();

      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    var snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()!, snapshot.id));
  }
}
