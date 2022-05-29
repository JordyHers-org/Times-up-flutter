// import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:parental_control/services/app_usage_local_service.dart';

class ChildModel {
  ChildModel(
      {@required this.id,
      @required this.name,
      @required this.email,
      this.image,
      this.token,
      this.position,
      this.appsUsageModel});

  final String name;
  final String email;
  final String image;
  final String id;
  final GeoPoint position;
  List<dynamic> appsUsageModel = <AppUsageInfo>[];
  String token;

  factory ChildModel.fromMap(Map<dynamic, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String image = data['image'];
    final String email = data['email'];
    final String token = data['token'];
    final List<dynamic> apps = data['appsUsageModel'];
    final GeoPoint position = data['position'];

    return ChildModel(
        id: documentId,
        name: name,
        image: image,
        email: email,
        token: token,
        position: position,
        appsUsageModel: apps ?? []);
    //appsUsageModel: apps);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'position': position,
      'token': token,
      'appsUsageModel': appsList(appsUsageModel),
      //'appsUsageModel': null,
    };
  }

  @override
  String toString() =>
      'id: $id , name: $name , latitude:${position.latitude} , longitude:${position.longitude} ';
}

List<Map<String, dynamic>> appsList(List<AppUsageInfo> apps) {
  if (apps == null) {
    return null;
  }
  var appsMap = <Map<String, dynamic>>[];
  apps.forEach((value) {
    appsMap.add(value.toMap());
  });
  return appsMap;
}

List<AppUsageInfo> _convertModel(List<dynamic> appsMod) {
  if (appsMod == null) {
    return null;
  }
  var apps = <AppUsageInfo>[];
  appsMod.forEach((value) {
    apps.add(AppUsageInfo.fromMap(value));
  });
  return apps;
}