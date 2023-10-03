// ignore_for_file: inference_failure_on_function_return_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';

typedef QueryBuilder<T> = T Function(Map<String, dynamic> data);

class FireStoreService {
  FireStoreService._();

  static final instance = FireStoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    JHLogger.$.d('$path: $data');
    await reference.set(data);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    JHLogger.$.d('$path: $data');

    await reference.update(data);
  }

  Future<void> setNotificationFunction({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference =
        FirebaseFirestore.instance.collection(path).doc(data['id'] as String?);
    JHLogger.$.d('$path: $data');

    await reference.set(data);
  }

  Future<void> sendEmail({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance.collection(path).doc().set(data);
    JHLogger.$.d('Welcome email sent to ${data['to']}');
  }

  Future<void> saveToken({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path).doc();
    JHLogger.$.d('$path: $data');

    await reference.set(data);
  }

  Future<void> deleteData({required String path, String? image}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    if (image != null) {
      final storageReference = FirebaseStorage.instance.refFromURL(image);
      await storageReference.delete();
      await reference.delete();
    }

    debugPrint('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required QueryBuilder<T> builder,
    Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    var query = FirebaseFirestore.instance.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query) as CollectionReference<Map<String, dynamic>>;
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data()))
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
      query = queryBuilder(query) as CollectionReference<Map<String, dynamic>>;
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
    final query = FirebaseFirestore.instance.collection(path);
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
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()!, snapshot.id));
  }
}
