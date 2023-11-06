import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';

class Dummy {
  static Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  static GeoPoint geoPoint = const GeoPoint(
    0,
    0,
  );

  static final childModel = ChildModel(
    id: '001',
    name: 'name',
    email: 'email',
    image: 'image',
    token: 'token',
    position: Dummy.geoPoint,
    appsUsageModel: [],
  );
}
